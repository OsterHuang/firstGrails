package com.thinkpower.course.domain

class Skill {

    static constraints = {
    }

    static belongsTo = [teacher:Teacher]

    String name;
}
