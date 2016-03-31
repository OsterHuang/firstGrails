<!doctype html>
<html>
<head>
    <asset:javascript src="jquery-2.2.0.min.js"/>
    <asset:javascript src="angular.min.js"/>
    <asset:javascript src="bootstrap.js"/>
    <asset:javascript src="pages/teacher.js"/>

    <asset:stylesheet src="bootstrap.css"/>
</head>
<body ng-app="teacherApp" ng-controller="teacherController">

    <div class="container-fluid">
        <!-- Message -->
        <div class="alert alert-success" id="message" style="position:absolute; z-index:99; float:right;">
            <button type="button" class="close-message" ng-click="hideMessage()">x</button>
            {{message}}
        </div>

        <button class="btn btn-default" style="margin-top:10px" ng-click="inquiryTeachers()">
            Refresh
        </button>
        <button class="btn btn-default" style="margin-top:10px" ng-click="isShowNewTeacher = true">
            New
        </button>

        <div class="panel panel-default" style="margin-top:10px">
            <div class="panel-heading">Teacher List</div>

            <!-- Table -->
            <table class="table table-strip" ng-show="teacherList">
                <tr>
                    <th>Name</th><th>Nickname</th><th>Age</th><th>Action</th>
                </tr>

                <!-- New teacher Area -->
                <tbody ng-show="isShowNewTeacher" style="background-color:#CCCCBB">
                    <td>
                        <input type="text" class="form-control" ng-model="newTeacher.name" placeholder="Name"/>
                    </td>
                    <td>
                        <input type="text" class="form-control" ng-model="newTeacher.nickname" placeholder="Nickname"/>
                    </td>
                    <td>
                        <input type="number" class="form-control" ng-model="newTeacher.age" placeholder="Age"/>
                    </td>
                    <td>
                        <button class="btn btn-primary" ng-click="createTeacher()">
                            Add
                        </button>
                        <button class="btn btn-warning" ng-click="isShowNewTeacher = false">
                            Hide
                        </button>
                    </td>
                </tbody>

                <!-- Teacher List -->
                <tbody ng-repeat="teacher in teacherList">
                    <tr>
                        <td>{{teacher.name}}</td>
                        <td>{{teacher.nickname}}</td>
                        <td>{{teacher.age}}</td>
                        <td>
                            <button class="btn btn-default btn-xs" ng-click="expandSkills(teacher, $index)">
                                <span ng-hide="teacher.isExpand">&darr;</span>
                                <span ng-show="teacher.isExpand">&uarr;</span>
                            </button>
                        </td>
                    </tr>
                    <tr ng-show="teacher.isExpand">
                        <td colspan="4">
                            <!-- Skill List -->
                            <span ng-repeat="skill in teacher.skills" style="border:1px solid #999999; border-radius:4px; margin:4px; padding:6px">
                                <span style="color:#AAAAAA; margin-right:4px">{{$index}}</span>
                                <span style="color:#666666">{{skill.name}}</span>
                            </span>

                            <div ng-show="!teacher.skills || teacher.skills.length == 0">
                                N/A
                            </div>

                            <!-- New Skill -->
                            <div class="input-group input-group-sm" style="width:33%; margin-top:10px">
                                <input type="text" class="form-control" ng-model="newSkill.name" placeholder="New Skill"/>
                                <span class="input-group-btn">
                                    <button class="btn btn-info" ng-click="addSkill(teacher)">
                                        Add Skill
                                    </button>
                                </span>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>

            <!-- No data -->
            <div class="panel-body" ng-show="!teacherList">
                No teacher here...
            </div>
        </div>
    </div>

</body>
</html>
