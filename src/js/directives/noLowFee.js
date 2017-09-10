'use strict';

angular.module('copayApp.directives')
  /**
   * Replaces img tag with its svg content to allow for CSS styling of the svg.
   */
  .directive('noLowFee', function($log, $ionicHistory, configService, popupService) {
    return {
      restrict: 'A',
      link: function(scope, elem, attrs, ctrl) {


        elem.bind('click', function() {
          configService.whenAvailable(function(config) {
            if (config.wallet.settings.feeLevel && config.wallet.settings.feeLevel.match(/conomy/)) {
              $log.debug('Economy Fee setting... disabling link:' + elem.text());
<<<<<<< HEAD
<<<<<<< HEAD
              popupService.showAlert('Low Fee Error', 'Please change your Ducatuscoin Network Fee Policy setting to Normal or higher to use this service', function() {
=======
              popupService.showAlert('Low Fee Error', 'Please change your DucatusCoin Network Fee Policy setting to Normal or higher to use this service', function() {
>>>>>>> 53ccad1a9a2a308ca50609c38d50eb28f16af81c
=======
              popupService.showAlert('Low Fee Error', 'Please change your Bitcoin Network Fee Policy setting to Normal or higher to use this service', function() {
>>>>>>> parent of fc2811a... Added changes in names
                $ionicHistory.goBack();
              });
            }
          });
        });
      }
    }
  });
