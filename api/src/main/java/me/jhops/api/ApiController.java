package me.jhops.api;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ApiController {

    @GetMapping("/")
	public String index() {
		return "Greetings from Spring Boot!";
	}
    
}
