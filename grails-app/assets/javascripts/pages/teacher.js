angular.module('teacherApp', []).controller('teacherController', function($scope, $http) {

    // ----
    // Data model
    // ----
    $scope.isShowNewTeacher = false;

    $scope.teacherList = [];
    $scope.newTeacher = {};
    $scope.message = "";

    $scope.newSkill = {};

    // ----
    // User interaction
    // ----
    $scope.hideMessage = function() {

        $("#message").hide();
    }

    $scope.inquiryTeachers = function() {
        $http({
            url: './inquiryTeachers',
            method: 'POST',
            data: JSON.stringify($scope.newTeacher),
            headers: {'Content-Type': 'application/json'}
        }).success(function(response) {
            console.log(response);

            $scope.teacherList = response;

        }).error(function(data, status) {
            console.log('Error ' + status + '. ' + data);
            $scope.message = response.message;
            $("#message").alert();
            $("#message").fadeTo(5000, 500).slideUp(500, function() {});
        });
    }

    $scope.createTeacher = function() {
        $http({
            url: './createTeacher',
            method: 'POST',
            data: JSON.stringify($scope.newTeacher),
            headers: {'Content-Type': 'application/json'}
        }).success(function(response) {
            console.log(response);

            if (response.result === 'Success') {
                $scope.newTeacher = {};
                $scope.inquiryTeachers();
            }

            $scope.message = response.message;
            $("#message").alert();
            $("#message").fadeTo(5000, 500).slideUp(500, function() {});
        }).error(function(data, status) {
            console.log('Error ' + status + '. ' + data);
            $scope.message = response.message;
            $("#message").alert();
            $("#message").fadeTo(5000, 500).slideUp(500, function() {});
        });
    }

    $scope.expandSkills = function(teacher, idx) {
        teacher.isExpand = teacher.isExpand ? false : true;
        if (teacher.isExpand)
            $scope.inquirySkills(teacher, idx);
    }

    $scope.addSkill = function(teacher) {
        var requestData = {
            teacherId:teacher.id,
            newSkill:$scope.newSkill
        };

        $http({
            url: './addSkill',
            method: 'POST',
            data: JSON.stringify(requestData),
            headers: {'Content-Type': 'application/json'}
        }).success(function(response) {
            console.log(response);

            if (response.result === 'Success') {
                $scope.newSkill = {};
                //$scope.inquiryTeachers();
                teacher.skills = response.data;
            }

            $scope.message = response.message;
            $("#message").alert();
            $("#message").fadeTo(5000, 500).slideUp(500, function() {});
        }).error(function(data, status) {
            console.log('Error ' + status + '. ' + data);
            $scope.message = response.message;
            $("#message").alert();
            $("#message").fadeTo(5000, 500).slideUp(500, function() {});
        });
    }

    $scope.inquirySkills = function(teacher, idx) {
        $http({
            url: './inquirySkills',
            method: 'POST',
            data: JSON.stringify({teacherId:teacher.id}),
            headers: {'Content-Type': 'application/json'}
        }).success(function(response) {
            console.log(response);

            if (response.result === 'Success') {
                //teacher.skills = response.data.skills;
                $scope.teacherList[idx].skills = response.data;
            } else {
                $scope.message = response.message;
                $("#message").alert();
                $("#message").fadeTo(5000, 500).slideUp(500, function() {});
            }
        }).error(function(data, status) {
            console.log('Error ' + status + '. ' + data);
            $scope.message = response.message;
            $("#message").alert();
            $("#message").fadeTo(5000, 500).slideUp(500, function() {});
        });
    }

    //Initial
    $scope.inquiryTeachers();
    $scope.hideMessage();

});