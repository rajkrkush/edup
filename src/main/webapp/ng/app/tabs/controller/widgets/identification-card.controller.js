'use strict';

angular.module('edup.tabs')

    .controller('IdentificationCardController', function ($scope) {

        $scope.addToBalance = function (value) {
            $scope.selectedStudent.balance = $scope.selectedStudent.balance + parseInt(value);
        };

    }
);

