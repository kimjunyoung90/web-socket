<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>채팅</title>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

    <script>
        let wsocket;
        function connect() {
            wsocket = new WebSocket('ws://localhost:8080/chat-ws');
            wsocket.onopen = onOpen;
            wsocket.onmessage = onMessage;
            wsocket.onclose = onClose;
        }

        function appendMessage(msg) {
            $('#chatMessageArea').append(msg + '<br>');
            const chatAreaHEight = $('#chatArea').height();
            const maxScroll = $('#chatMessageArea').height() - chatAreaHEight;
            $('#chatArea').scrollTop(maxScroll);
        }

        function onOpen(evt) {
            appendMessage("연결되었습니다.");
        }

        function onMessage(evt) {
            const data = evt.data;
            if(data.substring(0, 4) === 'msg:') {
                appendMessage(data.substring(4));
            }
        }

        function onClose(evt) {
            appendMessage("연결을 끊었습니다.")
        }


        function send() {
            const nickname = $('#nickname').val();
            const msg = $('#message').val();
            wsocket.send('msg:' + nickname + ':' + msg);
            $('#message').val('');
        }

        function disconnect() {
            wsocket.close();
        }

        $(document).ready(function () {
            $('#message').keypress(function (event) {
                const keycode = (event.keyCode ? event.keyCode : event.which);
                if(keycode === 13) {
                    send();
                }
                event.stopPropagation();
            });
            $('#sendBtn').click(function () { send(); });
            $('#enterBtn').click(function () { connect(); });
            $('#exitBtn').click(function () { disconnect(); });
        });
    </script>
    <style>
        #chatArea {
            width: 200px; height: 100px; overflow-y: auto; border: 1px solid black;
        }
    </style>
</head>
<body>
    이름:<input type="text" id="nickname">
    <input type="button" id="enterBtn" value="입장">
    <input type="button" id="exitBtn" value="나가기">

    <h1>대화 영역</h1>
    <div id="chatArea">
        <div id="chatMessageArea"></div>
    </div>
    <br/>
    <input type="text" id="message">
    <input type="button" id="sendBtn" value="전송">
</body>
</html>
