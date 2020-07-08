package kimgibeom.dog.common.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/admin/common")
public class AdminLogoController {
	@Value("${logoAttachDir}")
	private String logoAttachDir;

	@RequestMapping("/logoRegist")
	public void logoRegister() {
	}

	@RequestMapping(value = "/logoRegistProc", method = RequestMethod.POST)
	@ResponseBody
	public boolean logoRegistProc(MultipartFile attachFile, HttpServletRequest request) {

		boolean stored = true;
		String dir = request.getServletContext().getRealPath(logoAttachDir);

		try {
			save(dir + "/" + "logo.jpg", attachFile);
		} catch (IOException e) {
			stored = false;
		}

		return stored;
	}

	private void save(String fullPath, MultipartFile attachFile) throws IllegalStateException, IOException {
		attachFile.transferTo(new File(fullPath));
	}
}