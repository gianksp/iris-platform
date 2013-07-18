<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0;">
        <title>I.R.I.S</title>
        <c:url value="/resources/css/style.css" var="cssURL" />  
        <link rel="stylesheet" type="text/css" media="screen" href="${cssURL}" />  
        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script type="text/javascript">
            $(function() {

                var conn;
                var msg = $("#msg");
                var log = $("#log");

                function appendLog(msg) {
                    var d = log[0]
                    var doScroll = d.scrollTop == d.scrollHeight - d.clientHeight;
                    msg.appendTo(log)
                    if (doScroll) {
                        d.scrollTop = d.scrollHeight - d.clientHeight;
                    }
                }

                $("#form").submit(function() {
                    if (!conn) {
                        return false;
                    }
                    if (!msg.val()) {
                        return false;
                    }
                    conn.send(msg.val());
                    appendLog($("<div>You: " + msg.val() + "</div>"))
                    msg.val("");
                    return false
                });

                if (window["WebSocket"]) {
                    conn = new WebSocket("ws://localhost:8080/service/websocket");
                    conn.onclose = function(evt) {
                        appendLog($("<div><b>Connection closed.</b></div>"))
                    }
                    conn.onmessage = function(evt) {
                        appendLog($("<div/>").text("Iris: " + evt.data))
                    }
                } else {
                    appendLog($("<div><b>Your browser does not support WebSockets.</b></div>"))
                }
            });
        </script>
        <style type="text/css">
            /*html {
                overflow: hidden;
            }
            
            body {
                overflow: hidden;
                padding: 0;
                margin: 0;
                width: 100%;
                height: 100%;
                background: gray;
            }
            
            #log {
                background: white;
                margin: 0;
                padding: 0.5em 0.5em 0.5em 0.5em;
                position: absolute;
                top: 0.5em;
                left: 0.5em;
                right: 0.5em;
                bottom: 3em;
                overflow: auto;
            }
            
            #form {
                padding: 0 0.5em 0 0.5em;
                margin: 0;
                position: absolute;
                bottom: 1em;
                left: 0px;
                width: 100%;
                overflow: hidden;
            }
            */
        </style>
    </head>
    <body>
        <div id="login">
            <form id="form">
                <input type="submit" value="Send" />
                <input type="text" id="msg" size="64"/>
            </form>
            <div id="log"></div>
        </div>
    </body>
</html>