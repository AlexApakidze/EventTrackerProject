package com.skilldistillery.hvacpm.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	
	@GetMapping("pms/{id}")
	HvacPm getPmById(@PathVariable("id") Integer pmId, HttpServletResponse res) {
		HvacPm pm = pmService.getById(pmId);
		if (pm == null) {
			res.setStatus(404);
		}
		return pm;
	}
	
	@PostMapping("pms")
	public HvacPm createHvacPm(@RequestBody HvacPm pm, HttpServletResponse res, HttpServletRequest req) {
		System.out.println(pm);
		try {
			pm = pmService.create(pm);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(pm.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			pm = null;
		}
		return pm;
	}
	@PutMapping("pms/{pmId}")
	public HvacPm updateHvacPm(@PathVariable int pmId, @RequestBody HvacPm pm, HttpServletResponse res) {
		try {
			pm = pmService.update(pmId, pm);
			if (pm == null) {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
		return pm;
	}
	
	@DeleteMapping("pms/{pmId}")
	public void deleteHvacPm(@PathVariable("pmId") Integer pmId, HttpServletResponse res) {
		try {
			if (pmService.delete(pmId)) {
				res.setStatus(200);
			} else {
				res.setStatus(404);
			}
		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
		}
	}
	
}
