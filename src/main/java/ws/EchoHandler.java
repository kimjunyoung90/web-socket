package ws;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class EchoHandler extends TextWebSocketHandler {
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        System.out.printf("%s 연결 됨\n", session.getId());
    }

    /**
     * @param session
     * @param message : 클라이언트가 전송한 텍스트 데이터를 담고 있음
     * @throws Exception
     */
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        //message.getPayload = message에서 텍스트 데이터를 구할 수 있다.
        System.out.printf("%s로부터 [%s] 받음\n", session.getId(), message.getPayload());
        //session.sendMessage = 웹 소켓 클라이언트에 데이터를 전송
        session.sendMessage(new TextMessage("echo: " + message.getPayload()));
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        System.out.printf("%s 연결 끊김\n", session.getId());
    }
}
