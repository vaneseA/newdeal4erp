package study.common.socket;

import kr.happyjob.study.common.socket.MessageDTO;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MessageHandler {

	private final Logger logger = LogManager.getLogger(this.getClass());

	@MessageMapping("/hello")
	@SendTo("/topic/user")
	public kr.happyjob.study.common.socket.MessageDTO helloWorld(MessageDTO message) throws Exception{
		logger.info("!socket! helloWorld "+ message);
		
		return message;
	}
}
