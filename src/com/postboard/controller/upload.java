package com.postboard.controller;

import java.io.FileOutputStream;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UncheckedIOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/back_end/PostBoard/upload.do")
@MultipartConfig
public class upload extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); // 為了處理中文檔名

		request.getParts().stream().filter(part -> !"upload".equals(part.getName())).forEach(this::write);
	}

	private void write(Part part) {
		String filename = part.getSubmittedFileName();
		try (InputStream in = part.getInputStream();
				OutputStream out = new FileOutputStream("c:/test/" + filename)) {
			byte[] buffer = new byte[1024];
			int length = -1;
			while ((length = in.read(buffer)) != -1) {
				out.write(buffer, 0, length);
			}
		} catch (IOException ex) {
			throw new UncheckedIOException(ex);
		}
	}
}