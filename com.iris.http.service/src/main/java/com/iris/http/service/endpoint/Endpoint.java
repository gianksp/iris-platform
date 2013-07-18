package com.iris.http.service.endpoint;

import ark.engine.core.Bot;
import ark.engine.core.Chat;
import org.apache.log4j.Logger;
import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.websocket.EncodeException;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import org.apache.log4j.BasicConfigurator;

/**
 * @author Giancarlo Sanchez
 */
@ServerEndpoint(value = "/websocket")
public class Endpoint {

    private static Logger LOG = Logger.getLogger(Endpoint.class);
    private static final Set<Session> peers = Collections.synchronizedSet(new HashSet<Session>());
    private Chat session;
    
    @PostConstruct
    private void initialize() {
        LOG.info("Initializing Endpoint");
        BasicConfigurator.configure();
        Bot bot = new Bot();
        session = new Chat(bot);
    }

    @PreDestroy
    private void destroy() {
        LOG.info("Destroying Endpoint");
    }

    @OnOpen
    public void onOpen(Session peer) throws IOException {
        LOG.info("Opening connection");


        String response = session.multisentenceRespond("Hello. How are you?");

        peer.getBasicRemote().sendText(response);
        peers.add(peer);
    }

    @OnClose
    public void onClose(Session peer) {
        LOG.info("Removing connection");
        peers.remove(peer);
    }

    @OnMessage
    public void message(String message, Session peer) throws IOException, EncodeException {
        LOG.info("Sending message");
        String response = session.multisentenceRespond(message);
        peer.getBasicRemote().sendObject(response);
        /*for (Session peer : peers) {
            peer.getBasicRemote().sendObject(message);
        }*/
    }
}
