package com.cognizant.springlearn;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@SpringBootApplication
public class SpringLearnApplication {

	private static final Logger LOGGER = LoggerFactory.getLogger(SpringLearnApplication.class);

	public static void main(String[] args) {
		LOGGER.info("Inside Main()");
		SpringApplication.run(SpringLearnApplication.class, args);

		SpringLearnApplication app = new SpringLearnApplication();
		app.displayDate();      // Hands-on 2
		app.displayCountry();   // Hands-on 4
	}

	public void displayDate() {
		LOGGER.info("START");

		ApplicationContext context = new ClassPathXmlApplicationContext("date-format.xml");
		SimpleDateFormat format = context.getBean("dateFormat", SimpleDateFormat.class);

		try {
			Date date = format.parse("31/12/2018");
			LOGGER.debug("Date: {}", date);
		} catch (ParseException e) {
			LOGGER.error("Parse Error", e);
		}

		LOGGER.info("END");
	}

	public void displayCountry() {
		LOGGER.info("START");

		ApplicationContext context = new ClassPathXmlApplicationContext("country.xml");
		Country country = context.getBean("country", Country.class);

		LOGGER.debug("Country : {}", country.toString());

		LOGGER.info("END");
	}
}
