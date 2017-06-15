/**
 * Socket IO client
 * @author UTC.KongLtn
 * LastUpdate Dec 21, 2015.
 */


/**
 * Variables of socket Event
 * @type {{server: string, wrapId: string, createMessagesButton: string, messageMenu: string, observationMenu: string, createMessagesForm: string, allNotify: string, commentRow: string, containerCommentReply: string, dismissJoinOption: string, join: string, dismiss: string, notificationId: string, clickDelNotification: string, showNumberNotify: string, countAllNotify: string, invitationWrapper: string, clickClearAllNotification: string, sessionIdOfPlaning: string, sessionIdOfObservation: string, plannedTabData: string, activeTabData: string}}
 */
var socketEventId = {
    //server: 'http://localhost:5000',
    server: 'https://obooknodeserver.herokuapp.com/',
    notifyList: "#notifyList",
    numNotify: "#numNotify",
    messList: "#messList",
    numMess: "#numMess",
    soundNotify: "#soundNotify"
};
/**
 * Current Socket
 * @type {null}
 */
var socket = null;
/**
 * Current User Id
 */
var isGuestId = null;

/**
 * Socket Event
 * @type {{init: Function, connectSocket: Function, socketEmitMessage: Function, showNumberOfCounter: Function, socketEmitCommentToServer: Function, socketEmitSessionToServer: Function, addNotificationItem: Function, socketEmitDeleteComment: Function, clickJoinOrDismissInNotification: Function, clickDeleteNotification: Function, countNotifyToRelatedSocket: Function, loadAjaxCountNotify: Function, showTheNumberOfNotification: Function, clickToNotifyDetail: Function, pushNotifyToMobile: Function, removeJoinDismissWrapper: Function, pushSessionJsonToInvitation: Function, clickClearAllNotification: Function, clearAllNotificationHTML: Function, deleteSessionInPlaning: Function, removeSessionAtAllRelatedSocket: Function, commentImageFromAppToSockets: Function, commentVideoFromAppToSockets: Function, changeSessionStatusToServer: Function, swapSessionBetweenPlannedAndActive: Function, reloadSessionToServer: Function, pushSessionHTMLData: Function, removeSessionWhenClickDismissInModal: Function}}
 */
var socketEvent = {
    /**
     * Init function
     * @return {undefined}
     */
    init: function () {
        var isGuest = $('#currentUser').val();
        isGuestId = isGuest;
        if (isGuest !== "0") {
            this.connectSocket(isGuest);
            //this.clickJoinOrDismissInNotification();
        }
    },
    /**
     * Create socket connect to nodeJS server
     * @param userId
     * @return {undefined}
     */
    connectSocket: function (userId) {
        // Create a connection to NodeJS server port 5000
        socket = io.connect(socketEventId.server);
        /**
         * Post userId to NodeJS server
         * @return {undefined}
         */
        socket.on('connect', function () {
            socket.emit('getSocketUser', {userId: userId});
        });

        /**
         * Push message to related sockets by ajax
         * @param idMessage
         * @return {undefined}
         */

        socket.on('resSendNotification', function (data) {
            var notifyWrapObj = $(socketEventId.notifyList);
            var numNotifyObj = $(socketEventId.numNotify);
            var messWrapObj = $(socketEventId.messList);
            var numMessObj = $(socketEventId.numMess);
            var soundNotifyObj = $(socketEventId.soundNotify);
            var numNotifyValue = parseInt(numNotifyObj.text());
            var numMessValue = parseInt(numMessObj.text());
            switch (data.type) {
              case "LIKE":{
                  var notifyContent = [
                    '<li>',
                      '<a class="alert alert-callout alert-info" href="/profile/'+data.currentUserID+'">',
                        '<img class="pull-right img-circle dropdown-avatar" src="'+data.currentUserImage+'" alt="" />',
                        '<strong>'+data.currentUserName+'</strong></br> ',
                        '<small>liked your Activity.</small>',
                      '</a>',
                    '</li>',
                  ].join('\n');
                  notifyWrapObj.after(notifyContent);
                  if(isNaN(numNotifyValue)){
                    numNotifyObj.text(1);
                  }
                  else{
                    numNotifyObj.text(parseInt(numNotifyObj.text()) + 1);
                  }
                  soundNotifyObj[0].play();
                  alert('Have new notify');
                }
                break;
                case "MESS":{
                    var messContent = [
                      '<li>',
                        '<a class="alert alert-callout alert-info" href="/profile/'+data.currentUserID+'">',
                          '<img class="pull-right img-circle dropdown-avatar" src="'+data.currentUserImage+'" alt="" />',
                          '<strong>'+data.currentUserName+'</strong></br> ',
                          '<small>sent message to you.</small>',
                        '</a>',
                      '</li>',
                    ].join('\n');
                    messWrapObj.after(messContent);
                    if(isNaN(numMessValue)){
                      numMessObj.text(1);
                    }
                    else{
                      numMessObj.text(parseInt(numMessObj.text()) + 1);
                    }
                    soundNotifyObj[0].play();
                    alert('Have new notify');
                  }
                  break;
              default:
                console.log('Tính sau!'); break;
            }
        });

        socket.on('resLoadNotification',function(data){
          console.log(data);
          var notifyWrapObj = $(socketEventId.notifyList);
          var numNotifyObj = $(socketEventId.numNotify);
          var notifyContent = [
                '<li>',
                  '<a class="alert alert-callout alert-info" href="/profile/'+data.user_effect_id+'">',
                    '<img class="pull-right img-circle dropdown-avatar" src="'+data.user_effect_image+'" alt="" />',
                    '<strong>'+data.user_effect_name+'</strong></br> ',
                    '<small>liked your Activity.</small>',
                  '</a>',
                '</li>',
              ].join('\n');
          notifyWrapObj.after(notifyContent);
          numNotifyObj.text(data.numNotify);
        });

        socket.on('resLoadNotificationMess',function(data){
          var messWrapObj = $(socketEventId.messList);
          var numMessObj = $(socketEventId.numMess);
          var notifyContent = [
                '<li>',
                  '<a class="alert alert-callout alert-info" href="/profile/'+data.user_effect_id+'">',
                    '<img class="pull-right img-circle dropdown-avatar" src="'+data.user_effect_image+'" alt="" />',
                    '<strong>'+data.user_effect_name+'</strong></br> ',
                    '<small>sent message to you.</small>',
                  '</a>',
                '</li>',
              ].join('\n');
          messWrapObj.after(notifyContent);
          numMessObj.text(data.numNotify);
        });
    },
    /**
     * Client socket emit message to invited userIds
     * @param objData
     */
    sendNotification: function (objData) {
        socket.emit('sendNotification', objData);
    },

    loadNotification: function () {
        socket.emit('loadNotification',{userId: isGuestId});
    },
   };
