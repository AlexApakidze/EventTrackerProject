package com.skilldistillery.hvacpm.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.hvacpm.entities.HvacPm;
import com.skilldistillery.hvacpm.services.HvacPmService;

@RestController
@RequestMapping("api")
public class HvacPmController {

	@Autowired
	private HvacPmService pmService;
	
	@GetMapping("hvacpms")
	List<HvacPm> listPms(){
		return pmService.listAllPms();
	}
}
