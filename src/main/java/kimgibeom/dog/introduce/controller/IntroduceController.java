package kimgibeom.dog.introduce.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/introduce")
public class IntroduceController {
	@RequestMapping("/introduceView")
	public void introducView() {
	}
}