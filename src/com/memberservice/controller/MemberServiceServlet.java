package com.memberservice.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.websocket.SendResult;

import com.member.model.MemberService;
import com.member.model.MemberVO;
import com.memberservice.model.MemberServiceDAO;
import com.memberservice.model.MemberServiceService;
import com.memberservice.model.MemberServiceVO;
import com.order.model.OrderMasterDAOImpl;
import com.order.model.OrderMasterVO;
import com.problemtype.model.ProblemTypeService;
import com.product.model.ProdService;
import com.product.model.ProdVO;

import util.MailService;

@WebServlet("/MemberServiceServlet")
@MultipartConfig
public class MemberServiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				Integer msgID = new Integer(req.getParameter("msgID"));

				MemberServiceService msSvc = new MemberServiceService();
				MemberServiceVO msVO = msSvc.getOneMemberService(msgID);

				OutputStream os = res.getOutputStream();
				String pic = req.getParameter("pic");

				byte[] pic2 = msVO.getPic2();
				byte[] pic1 = msVO.getPic1();
				byte[] pic3 = msVO.getPic3();

				switch (pic) {
				case "1":
					os.write(pic1);
					break;
				case "2":
					os.write(pic2);
					break;
				case "3":
					os.write(pic3);
					break;
				}
				return;

//				if (msVO == null) {
//					errorMsgs.add("????????????");
//				}
				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req.getRequestDispatcher("/emp/select_page.jsp");
//					failureView.forward(req, res);
//					return;// ????????????
//				}
//
//				/*************************** 3.????????????,????????????(Send the Success view) *************/
//				req.setAttribute("msVO", msVO); // ??????????????????empVO??????,??????req
//				String url = "/front_end/memberservice/listOneProblemMsg.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // ???????????? listOneEmp.jsp
//				successView.forward(req, res);
			} catch (Exception e) {
				errorMsgs.add("??????????????????:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/emp/select_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.?????????????????? ****************************************/
				Integer msgID = new Integer(req.getParameter("msgID"));

				/*************************** 2.?????????????????? ****************************************/
				MemberServiceService msSvc = new MemberServiceService();
				MemberServiceVO msVO = msSvc.getOneMemberService(msgID);

				/*************************** 3.????????????,????????????(Send the Success view) ************/
				req.setAttribute("msVO", msVO);
				String url = "/emp/update_emp_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** ??????????????????????????? **********************************/
			} catch (Exception e) {
				errorMsgs.add("??????????????????????????????:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/emp/listAllEmp.jsp");
				failureView.forward(req, res);
			}
		}
		if ("update".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {

				String msgRes = null;

				Integer msgID = new Integer(req.getParameter("msgID"));
				System.out.println("msgID ="+msgID);

				Integer prodID = new Integer(req.getParameter("prodID"));
//				System.out.println("prodID ="+prodID);
				if (prodID.intValue() == 0) {
					prodID = null;
				}

				Integer memberID = new Integer(req.getParameter("memberID"));
//				System.out.println("memberID ="+memberID);

				Integer managerID = new Integer(req.getParameter("managerID"));
//				System.out.println("managerID ="+managerID);
				if (managerID.intValue() == 0) {
					managerID = null;
				}

				Integer typeID = new Integer(req.getParameter("typeID"));
//				System.out.println("typeID ="+typeID);

				Integer ordID = new Integer(req.getParameter("ordID"));
//				System.out.println("ordID ="+ordID);
				if (ordID.intValue() == 0) {
					ordID = null;
				}

				Date date = new Date();
				long ord = date.getTime();
				Timestamp msgDate = new Timestamp(ord);

//				System.out.println("???????????? : " + msgDate);

				String problemMsg = req.getParameter("problemMsg");
//				System.out.println("problemMsg ="+problemMsg);

				if (req.getParameter("msgRes") != null) {
					msgRes = req.getParameter("msgRes").trim();
				} else {

				}

				MemberServiceService realmsSvc = new MemberServiceService();
				MemberServiceVO realMsVO = realmsSvc.getOneMemberService(msgID);

				Integer problemStatus = new Integer(req.getParameter("problemStatus"));
//			System.out.println("????????????"+problemStatus);

				MemberServiceVO msVO = new MemberServiceVO();

				msVO.setMsgID(realMsVO.getMsgID());
				msVO.setProdID(prodID);
				msVO.setMemberID(memberID);
				msVO.setManagerID(managerID);
				msVO.setTypeID(typeID);
				msVO.setOrdID(ordID);
				msVO.setMsgDate(msgDate);
				msVO.setProblemMsg(problemMsg);
				msVO.setMsgRes(msgRes);
				msVO.setPic1(realMsVO.getPic1());
				msVO.setPic2(realMsVO.getPic2());
				msVO.setPic3(realMsVO.getPic3());
				msVO.setProblemStatus(problemStatus);
				msVO.setProdID(prodID);

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("msVO", msVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/emp/update_emp_input.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.?????????????????? *****************************************/
				MemberServiceService msSvc = new MemberServiceService();
				msVO = msSvc.updateMemberService(msgID, prodID, memberID, managerID, typeID, ordID, msgDate, problemMsg,
						msgRes, realMsVO.getPic1(), realMsVO.getPic2(), realMsVO.getPic3(), problemStatus);
				
				System.out.println("????????????msgID" + msVO.getMsgID());
				/*************************** 3.????????????,????????????(Send the Success view) *************/
				req.setAttribute("msVO", msVO); // ?????????update?????????,????????????empVO??????,??????req

				MailService mail = new MailService();
				MemberService memsv = new MemberService();

				MemberVO memVO = memsv.getOneMember(memberID);
				memVO.getEmail();
				memVO.getNickName();

				MemberServiceService memssv = new MemberServiceService();
				Timestamp pdate = memssv.getOneMemberService(msgID).getMsgDate();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

				ProblemTypeService ptsv = new ProblemTypeService();
				String ptmsg = ptsv.getOneProblemType(typeID).getTypeName();

				mail.sendMail(memVO.getEmail(), "????????????", "?????????" + memVO.getNickName() + "???????????????" + sdf.format(pdate)
						+ "????????????" + ptmsg + "???????????????????????????JoyLease????????????????????????");

				String url = "/back_end/memberservice/listAllProblemMsg.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ???????????????,??????listOneEmp.jsp
				successView.forward(req, res);

				/*************************** ??????????????????????????? *************************************/
			} catch (Exception e) {
				errorMsgs.add("??????????????????:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/memberservice/listAllProblemMsg.jsp");
				failureView.forward(req, res);
			}
		}
		if ("xxx".equals(action)) { // ??????update_emp_input.jsp?????????

			List<String> errorMsgs = new LinkedList<String>();

			req.setAttribute("errorMsgs", errorMsgs);
//			System.out.println("?????????");
			try {
				/*************************** 1.?????????????????? - ??????????????????????????? **********************/
//				Integer prodID = new Integer(req.getParameter("prodID").trim());
//				Integer memberID = new Integer(req.getParameter("memberID").trim());
//				Integer managerID = new Integer(req.getParameter("managerID").trim());
//				Integer typeID = new Integer(req.getParameter("typeID").trim());
//				Integer ordID = new Integer(req.getParameter("ordID").trim());

				Date date = new Date();
				long ord = date.getTime();
				Timestamp msgDate = new Timestamp(ord);

//				System.out.println("???????????? : " + msgDate);

				String problemMsg = req.getParameter("problemMsg");
				String problemMsgReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (problemMsg == null || problemMsg.trim().length() == 0) {
					errorMsgs.add("????????????: ????????????");
				} else if (!problemMsg.trim().matches(problemMsgReg)) {
					errorMsgs.add("????????????: ???????????????????????????????????????_ , ??????????????????2???10??????");
				}
				String msgRes = req.getParameter("msgRes").trim();
				if (msgRes == null || msgRes.trim().length() == 0) {
					errorMsgs.add("??????????????????");
				}

				Part pic1 = req.getPart("pic1");
				InputStream in1 = pic1.getInputStream();
				byte[] buf1 = new byte[in1.available()];
				in1.read(buf1);
				in1.close();
//				System.out.println("buffer lenght:"+ buf1.length);

				Part pic2 = req.getPart("pic2");
				InputStream in2 = pic2.getInputStream();
				byte[] buf2 = new byte[in2.available()];
				in2.read(buf2);
				in2.close();
//				System.out.println("buffer lenght:"+ buf2.length);

				Part pic3 = req.getPart("pic3");
				InputStream in3 = pic3.getInputStream();
				byte[] buf3 = new byte[in3.available()];
				in3.read(buf3);
				in3.close();
//				System.out.println("buffer lenght:"+ buf3.length);

				Integer problemStatus = new Integer(req.getParameter("problemStatus").trim());

				MemberServiceVO msVO = new MemberServiceVO();

//				msVO.setProdID(prodID);
//				msVO.setMemberID(memberID);
//				msVO.setManagerID(managerID);
//				msVO.setTypeID(typeID);
//				msVO.setOrdID(ordID);
//				msVO.setMsgDate(msgDate);
//				msVO.setProblemMsg(problemMsg);
//				msVO.setMsgRes(msgRes);				
//				msVO.setPic1(buf1);
//				msVO.setPic2(buf2);
//				msVO.setPic3(buf3);
//				msVO.setProblemStatus(problemStatus);
//				msVO.setProdID(prodID);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("msVO", msVO); // ???????????????????????????empVO??????,?????????req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back_end/problemtype/problemTypeReport.jsp");
					failureView.forward(req, res);
					return; // ????????????
				}

				/*************************** 2.?????????????????? *****************************************/
				MemberServiceService msSvc = new MemberServiceService();
//				msVO = msSvc.addMemberService(prodID, memberID, managerID, typeID, ordID, msgDate,problemMsg,msgRes,buf1,buf2,buf3,problemStatus);

				/*************************** 3.????????????,????????????(Send the Success view) *************/
//				String url = "/emp/listOneEmp.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // ???????????????,??????listOneEmp.jsp
//				successView.forward(req, res);

				/*************************** ??????????????????????????? *************************************/
			} catch (Exception e) {
				errorMsgs.add("??????????????????:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/problemtype/problemTypeReport.jsp");
				failureView.forward(req, res);
			}
		}
		if ("delete".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();

			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.?????????????????? ***************************************/
				Integer msgID = new Integer(req.getParameter("msgID"));

				/*************************** 2.?????????????????? ***************************************/
				MemberServiceService msSvc = new MemberServiceService();
				msSvc.deleteMemberService(msgID);

				/*************************** 3.????????????,????????????(Send the Success view) ***********/
				String url = "/emp/listAllEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** ??????????????????????????? **********************************/
			} catch (Exception e) {
				errorMsgs.add("??????????????????:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/emp/listAllEmp.jsp");
				failureView.forward(req, res);
			}
		}
		if ("insert".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				Integer memID = new Integer(req.getParameter("memberID"));
//				System.out.println(memID);

				Integer typeID = new Integer(req.getParameter("typeID"));
//				System.out.println(typeID);

				Integer prodID = null;
				if (req.getParameter("prodID") != null && req.getParameter("prodID").length() != 0) {
					prodID = new Integer(req.getParameter("prodID"));
				}
//				System.out.println(prodID);

				Integer ordID = null;
				if (req.getParameter("ordID") != null && req.getParameter("ordID").length() != 0) {
					ordID = new Integer(req.getParameter("ordID"));
				}

//					}		

				String pm = req.getParameter("problemmsg");

				Part img1 = req.getPart("pic1");
				img1 = img1.getSize() == 0 ? null : img1;
				byte[] pic1 = null;
//				System.out.println("part" +img1);
				if (img1 != null) {
					InputStream in1 = img1.getInputStream();
					pic1 = new byte[in1.available()];
					in1.read(pic1);
					in1.close();
//				System.out.println("buffer lenght:"+ pic1.length);
				}

				Part img2 = req.getPart("pic2");
				img2 = img2.getSize() == 0 ? null : img2;
				byte[] pic2 = null;
				if (img2 != null) {
					InputStream in2 = img2.getInputStream();
					pic2 = new byte[in2.available()];
					in2.read(pic2);
					in2.close();
//				System.out.println("buffer lenght:"+ pic2.length);
				}

				byte[] pic3 = null;
				Part img3 = req.getPart("pic3");
				img3 = img3.getSize() == 0 ? null : img3;
				if (img3 != null) {
					InputStream in3 = img3.getInputStream();
					pic3 = new byte[in3.available()];
					in3.read(pic3);
					in3.close();
//				System.out.println("buffer lenght:"+ pic3.length);
				}

				MemberServiceVO msVO = new MemberServiceVO();

				msVO.setMemberID(memID);
				msVO.setTypeID(typeID);
				msVO.setProblemMsg(pm);
				msVO.setOrdID(ordID);
				msVO.setProdID(prodID);
				msVO.setPic1(pic1);
				msVO.setPic2(pic2);
				msVO.setPic3(pic3);
				msVO.setProblemStatus(0);
				// 0:?????????
				// 1:?????????

				MemberServiceDAO dao = new MemberServiceDAO();
				dao.insert(msVO);

				String url = req.getContextPath()+"/front_end/memberservice/listAllMemberProblem.jsp";
				res.sendRedirect(url);
//				RequestDispatcher successView = req.getRequestDispatcher(url);// ???????????????,????????????????????????????????????
//				successView.forward(req, res);

			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		if ("detail".equals(req.getParameter("action"))) {

			String msgID = req.getParameter("msgID");

			MemberServiceService msSvc = new MemberServiceService();

			MemberServiceVO msVO = msSvc.getOneMemberService(Integer.valueOf(msgID));

			OutputStream os = res.getOutputStream();
			String pic = req.getParameter("pic");
//	System.out.println("picno" +pic);
			try {
				byte[] pic2 = msVO.getPic2();
				byte[] pic1 = msVO.getPic1();
				byte[] pic3 = msVO.getPic3();

//		System.out.println(msgID+" : " + pic1);
//		System.out.println(msgID+" : " + pic2);
//		System.out.println(msgID+" : " + pic3);
				switch (pic) {
				case "1":
					os.write(pic1);
					break;
				case "2":
					os.write(pic2);
					break;
				case "3":
					os.write(pic3);
					break;
				}
//	System.out.println("pic1:" + pic);
//
//		
//	if(pic1!=null &&pic.equals("1")) {
//		os.write(pic1);
//	}
//		
//	if(pic2!=null && pic2.equals("2"))
//		os.write(pic2);
//	

//	byte[] pic3 = msVO.getPic3();
//	if(pic3!=null)
//		os.write(pic3);
			} catch (Exception e) {
				// TODO: handle exception
				os.close();
			}

//			Integer prodID = 0;
//			ProdService prodSvc = new ProdService();
//			//????????????
//			if (req.getParameter("prodID") != null && !req.getParameter("prodID").isEmpty()) {
//				prodID = Integer.parseInt(req.getParameter("prodID"));
//			}
//		
//			ProdVO prod = prodSvc.findProductByPK(prodID);
//			
//			
//			OutputStream os = res.getOutputStream();
//			byte[] pic1 = prod.getPic1();
//			byte[] pic2 = prod.getPic2();
//			byte[] pic3 = prod.getPic3();
//
//			String no = req.getParameter("no");
//			if (no != null) {
//				switch (no) {
//				case "1":
//					if (pic1 != null)
//						os.write(pic1);
//					break;
//				case "2":
//					if (pic2 != null)
//						os.write(pic2);
//					break;
//				case "3":
//					if (pic3 != null)
//						os.write(pic3);
//					break;
//				}
//
//			}

		}
		if ("get_date_manager_order".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			DateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
//	System.out.println("?????????????????????");
			try {

				String startDate = (String) req.getParameter("startDate");
//		System.out.println("???????????????"+startDate);
				if (startDate == null || (startDate.trim()).length() == 0) {
					errorMsgs.add("???????????????");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back_end/memberservice/listAllProblemMsg.jsp");
					failureView.forward(req, res);
					return;// ????????????
				}

				String endDate = (String) req.getParameter("endDate");
//		System.out.println("???????????????"+endDate);
				if (endDate == null || (endDate.trim()).length() == 0) {
					errorMsgs.add("???????????????");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back_end/memberservice/listAllProblemMsg.jsp");
					failureView.forward(req, res);
					return;// ????????????
				}

				java.sql.Timestamp sd = java.sql.Timestamp.valueOf(startDate);
				java.sql.Timestamp ed = java.sql.Timestamp.valueOf(endDate);

				MemberServiceDAO memdao = new MemberServiceDAO();
				List<MemberServiceVO> list = memdao.getAll();

				List<MemberServiceVO> list2 = new ArrayList<MemberServiceVO>();
				for (MemberServiceVO omVO : list) {
					if (omVO.getMsgDate().before(ed) && omVO.getMsgDate().after(sd)) {
//				System.out.println(omVO.getMsgDate());
						omVO.getMsgID();
						list2.add(omVO);
					}
				}
				req.setAttribute("list", list2);
				req.getRequestDispatcher("/back_end/memberservice/listAllProblemMsg.jsp").forward(req, res);
				return;
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("??????????????????:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/memberservice/listAllProblemMsg.jsp");
				failureView.forward(req, res);
			}
		}

	}

}
