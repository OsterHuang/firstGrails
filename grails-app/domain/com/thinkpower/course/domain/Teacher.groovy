package com.thinkpower.course.domain

class Teacher {

    static constraints = {
    }

    static hasMany = [skills:Skill];

    static mapping = {
        skills(sort: 'name');
    }

    String name;
    String nickname;
    Integer age;

}
