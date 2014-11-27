<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add a video</title>
        
<link rel="stylesheet" type="text/css"
	href="<c:url value='/resources/css/video-js.css'/>" />
<script src="<c:url value='/resources/js/videojs/video.js'/>"></script>
<script src="<c:url value='/resources/js/keyListener.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/angular/lib/angular/angular.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/angular/lib/angular/angular-route.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/angular/lib/angular/angular-sanitize.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/angular/lib/angular/angular-animate.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/angular/lib/angular/angular-resource.js'/>"></script>
 
<script type="text/javascript" src="<c:url value='/resources/js/angular/Show/Show.js'/>"></script>  
<script type="text/javascript" src="<c:url value='/resources/js/angular/Show/ShowChooser.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/angular/Show/ShowModule.js'/>"></script>    
    
<script type="text/javascript" src="<c:url value='/resources/js/angular/Video/Video.js'/>"></script>  
<script type="text/javascript" src="<c:url value='/resources/js/angular/Video/VideoPlayer.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/angular/Video/VideoModule.js'/>"></script>  
     

<script type="text/javascript" src="<c:url value='/resources/js/angular/app.js'/>"></script>


</head>
<body ng-app="givemeashow">
	<jsp:include page="shared/navBar.jsp"></jsp:include>
	
	<div class="mainContent row-fluid span12">
            <div class="row">
                <div id="videoTitle" class="col-xs-6 col-xs-offset-2"></div>
            </div>
            <div class="row">
              <div ng-view></div>
               
                <show-chooser></show-chooser>
                <div class="textContent col-xs-7 col-xs-offset-1">
                    <div id="aboutContent">
                        <h3>About</h3>
                        <hr/>
                        <p>
                            "Give Me A Show !" was developped to let you be lazier and happier.</br>
                            You can find another "Give Me.." website, but about musics at : 
                            <a href="http://givemeasong.net">Give Me A Song</a> </br>
                            It is our very first webSite and we need your feedbacks ! Contact us at : ogdabou@gmail.com.</br></br>
                            Dev stuff by Ogdabou</br>
                            Server stuff by Naixy</br>
                            Feel free to send me feedbacks : ogdabou@gmail.com</br>
                        </p>
                    </div>
                    <div id="controlsContent">
                        <h3>Controls</h3>
                        <hr/>
                        <h4>Keyboard</h4>
                        <ul>
                            <li>Left arrow : change to previous video.</li>
                            <li>Right arrow : random the next video.</li>
                        </ul>
                        <h4>Voice</h4>
                        <p>
                            We use a recent API which is only (for the moment) supported by Chrome. It cannot be used on Firefox. We will implement the 
                            thing on Firefox as soon as there is something available.</br>
                        </p>
                        <p>
                            We will work on a full voice-controlled website by the future.
                            Feel free to send us feedbacks and ideas.
                        </p>
                        <ul>
                            <li>"next" : random to the next video.</li>
                            <li>"previous" : go to the previous video.</li>
                            <li>"up" : up the volume by 10%</li>
                            <li>"down" : down the volume by 10%</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
<script type="text/javascript" language="javascript">
            $(".tab_content").hide();
            $(".file_content").hide();
            $("#aboutContent").hide();
            $("#controlsContent").hide();
            var aboutShown = "false";
            var playList = [];
            var controlsShown = "false";
          	document.onkeydown = changeOnKeyDown;
            
            var videosHystory = null;
            var path = new Array();
            var index = 0;
	
    
    function aboutClickHandler()
{
    if ((aboutShown === "true") && (controlsShown === "true"))
    {
        aboutShown = "false";
        $("#aboutContent").hide("slide", {direction: "right"}, 400);  
        $("#aboutLI").removeClass("active");
    }
    else if (aboutShown === "false" && controlsShown == "true")
    {
        aboutShown = "true";
        $("#aboutContent").show("slide", {direction: "right"}, 400);
        $("#aboutLI").addClass("active");
    }
    else if (aboutShown === "false" && controlsShown == "false")
    {
        aboutShown = "true";
        $("#aboutContent").show("slide", {direction: "right"}, 400);
        $("#aboutLI").addClass("active");
    }
}

function controlsClickHandler()
{
    if ((aboutShown === "true") && (controlsShown === "true"))
    {
        controlsShown = "false";
        $("#controlsContent").hide("slide", {direction: "right"}, 400);
        $("#controlsLI").removeClass("active");
    }
    else if (controlsShown === "false" && aboutShown == "true")
    {
        controlsShown = "true";
        $("#controlsContent").show("slide", {direction: "right"}, 400);
        $("#controlsLI").addClass("active");
    }
    else if (controlsShown === "false" && aboutShown == "false")
    {
        controlsShown = "true";
        $("#controlsContent").show("slide", {direction: "right"}, 400);
        $("#controlsLI").addClass("active");
    }
}
        </script>

</body>
</html>