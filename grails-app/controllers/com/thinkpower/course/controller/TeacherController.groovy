package com.thinkpower.course.controller

import com.thinkpower.course.domain.Skill
import com.thinkpower.course.domain.Teacher
import grails.converters.JSON
import groovy.util.logging.Slf4j

@Slf4j
class TeacherController {

    def index() {
        System.out.println('This is index');
    }

    def inquiryTeachers() {
        List<Teacher> teacherList = Teacher.list();
        log.info("inquiryTeachers() " +  teacherList);
        render(teacherList as JSON)
    }

    def createTeacher() {
        log.info("createTeacher() " + request.JSON);

        Teacher newTeacher = new Teacher(
            name:request.JSON.name,
            nickname: request.JSON.nickname,
            age: request.JSON.age
        ).save();

        def result;
        if (newTeacher != null)
            result = [result:'Success', 'message':'Create the teacher success.'];
        else
            result = [result:'Fail', 'message':"Can not create teacher."];
        render(result as JSON);
    }

    def inquirySkills() {
        log.info("inquirySkills() " + request.JSON);

        Teacher teacher = Teacher.get(request.JSON.teacherId);

        //Preload skills data
        List<Skill> skillList = new ArrayList<>();
        for (Skill skill : teacher.skills) {
            skillList.add(new Skill(name:skill.name));
        }

        log.info("Sorted skill list is " + skillList);

        def result;
        if (skillList != null)
            result = [result:'Success', data:skillList];
        else
            result = [result:'Fail', message:"Can't add skill."];
        render(result as JSON);
    }

    def addSkill() {
        log.info("addSkill() " + request.JSON);

        Teacher teacher = Teacher.get(request.JSON.teacherId);
        Skill newSkill = new Skill(name: request.JSON.newSkill.name);
        teacher.addToSkills(newSkill);
        teacher.save();

        //Preload skills data
        List<Skill> skillList = new ArrayList<>();
        for (Skill skill : teacher.skills) {
            skillList.add(new Skill(name:skill.name));
        }

        def result;
        if (teacher != null)
            result = [result:'Success', message:'Add skill.', data:skillList];
        else
            result = [result:'Fail', message:"Can't add skill."];
        render(result as JSON);

    }
}
