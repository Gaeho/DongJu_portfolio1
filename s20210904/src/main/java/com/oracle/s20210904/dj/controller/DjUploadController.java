package com.oracle.s20210904.dj.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.nio.file.Paths;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.s20210904.comm.model.Company;
import com.oracle.s20210904.dj.service.DjAnnoService;

@Controller
public class DjUploadController {
	
	private static final Logger logger = LoggerFactory.getLogger(DjAnnoWriteController.class);
	
	@Autowired
	private DjAnnoService das;
	
	//업로드123
		@PostMapping(value="/DjComImguploadForm" , produces = "application/text; charset=UTF-8")
		@ResponseBody
		public String uploadForm(HttpServletRequest request, Model model,MultipartFile file1,
				@RequestParam(value="comId1") String comId1) 
		
		throws Exception{
//			String uploadPath = request.getSession().getServletContext().getRealPath("/upload/");
			String uploadPath = request.getSession().getServletContext().getRealPath("/upload/");
			System.out.println("생성 시 uploadPath->"+uploadPath);
			//업로드 경로를 만든다. 메타데이터 아래에 경로를 둔다. 가장 아래에 upload라는 폴더를 만들고 거기에 파일을 둔다.
	
			System.out.println("uploadForm 시작되었습니다.");
			System.out.println("comId1->"+comId1);
			
			logger.info("originalName: "+file1.getOriginalFilename());//사진의 원래 이름을 보여준다
			
			logger.info("size: " + file1.getSize());//사진의 용량
			logger.info("contentType: " + file1.getContentType());//사진의 타입
			logger.info("uploadPath: " + file1); //업로드 경로
														
			String uploadinDB = uploadFile(file1.getOriginalFilename(),file1.getBytes(),uploadPath,comId1);
			logger.info("uploadinDB: "+uploadinDB);
			
			// model.addAttribute("savedName", savedName);
			//model.addAttribute("comId1", comId1);
			return uploadinDB;
		}	
	
		//uploadForm에서 호출하는 메소드이다.원래이름,용량,경로를 받아 처리한다.
		private String uploadFile(String originalName, byte[] fileData, String uploadPath,String comId1) 
		throws Exception{
			UUID uid = UUID.randomUUID();
			
			System.out.println("uploadPath->"+uploadPath);
			
			//업로드 폴더가 있는지 검사하여 없으면 생성한다.
			File fileDirectory = new File(uploadPath);
			if(!fileDirectory.exists()) { //만약 파일디렉토리가 존재하지 않는다면,
				fileDirectory.mkdirs(); // mkdirs=make directory 폴더를 만들어라
				System.out.println("업로드용 폴더 생성 : "+ uploadPath);
			}
			
			//저장이름을 만든다. 'uuid로 만든 문자열_원래이름' 조합하여 만든다.
			String savedName = uid.toString() + "_" + originalName;
			//uid를 String화 해서 원래 이름과 잇는다
			
			logger.info("UUID savedName: "+ savedName);
			

			File target = new File(uploadPath, savedName); //경로와 이름을 가지고 새로운 File 인스턴스 생성/생성만 했다.
			FileCopyUtils.copy(fileData, target); //org.springframework.util.FileCopyUtils
			// 파일 데이터, 경로, 이름을 복사한다. 그래서 올린다. 인스턴스를 저장한다.
			
			String uploadinDB = "/upload/"+savedName;
			System.out.println("uploadinDB에 경로가 들어갔나?"+uploadinDB);
//			이름에 /upload/를 앞에 붙여서 쉽게 꺼내 쓸 수 있도록 함
			
			Company comp = new Company();
			comp.setCom_img(uploadinDB);
			comp.setCom_id(comId1);
	
			int result = das.insertComImg(comp) ;
			
			if(result == 1) {
				System.out.println("기업 대표 사진 DB입력 완료");
			}else {
				System.out.println("기업 대표 사진 DB입력 실패");
			}
			

			return uploadinDB;//조합한 이름을 리턴한다.
		}

		@GetMapping(value="DjComImguploadForm", produces = "application/text; charset=UTF-8")//, method= RequestMethod.GET)
		@ResponseBody
		public String uploadFileDelete(HttpServletRequest request,Model model,
				@RequestParam(value="comImg123") String comImg123)  
				throws Exception{
			
			System.out.println("comImg123->"+comImg123);
			
//			String uploadPath = request.getSession().getServletContext().getRealPath("/upload/");
			String uploadPath = request.getSession().getServletContext().getRealPath("/");
			String deleteFile = uploadPath + comImg123;
			logger.info("deleteFile: "+deleteFile);
			System.out.println("uploadFielDelete 시작합니다.");
			int delResult = upFileDelete(deleteFile,comImg123);
			logger.info("deleteFile result-> "+delResult);
			model.addAttribute("deleteFile", deleteFile);
			model.addAttribute("delResult", delResult);

			String returnsomething = Integer.toString(delResult);
			return returnsomething;
		}
	
		private int upFileDelete(String deleteFileName,String imgpath11) throws Exception{
			
			int result = 0;
			logger.info("upFileDelete result -> "+deleteFileName);
			logger.info("imgpath11 -> "+imgpath11);
			File file = new File(deleteFileName);
			if(file.exists()) { 
				if(file.delete()) { //<--여기에서 파일이 물리적으로 삭제된다.
					System.out.println("파일삭제 성공");
					int resultofDelete = das.imgDel(imgpath11);
					
						if(resultofDelete == 1) {
							
							result = 1;
						} else {
							
							System.out.println("입력과정에서 무언가 문제가 생겼다");
							System.out.println("resultofDelete에 그럼 뭐가 들어 있는데?->"+resultofDelete);
							
						}
											
				} else {
					System.out.println("파일삭제 실패");
					result=0;
				}
			} else {
				System.out.println("파일이 존재하지 않습니다.");
				result = -1;
			}
			
			
			return result;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		@RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
		@ResponseBody
		public ResponseEntity<?> uploadFile(
		    @RequestParam("uploadfile") MultipartFile uploadfile) {
		  System.out.println("이건되냐안되냐아1111111111111111111111111111");
		  try {
		    // Get the filename and build the local file path (be sure that the 
		    // application have write permissions on such directory)
		    String filename = uploadfile.getOriginalFilename();
		    String directory = "/var/netgloo_blog/uploads";
		    String filepath = Paths.get(directory, filename).toString();
		    
		    // Save the file locally
		    BufferedOutputStream stream =
		        new BufferedOutputStream(new FileOutputStream(new File(filepath)));
		    stream.write(uploadfile.getBytes());
		    stream.close();
		  }
		  catch (Exception e) {
		    System.out.println(e.getMessage());
		    return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		  }
		  
		  return new ResponseEntity<>(HttpStatus.OK);
		} // method uploadFile
		

}
