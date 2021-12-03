package com.oracle.s20210904.dj.domain;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.oracle.s20210904.comm.model.Announce;
import com.oracle.s20210904.comm.model.Comm;
import com.oracle.s20210904.comm.model.Company;

@Repository
public class DjAnnoDaoImpl implements DjAnnoDao {

	@Autowired
	private SqlSession session;

	@Override
	public Company comInfoList(String com_id) {
		System.out.println("DjAnnoDaoImpl의 annoList1 시작되었습니다.");
		
		Company comp1 = null;
		
		try {
			
			comp1 = session.selectOne("DjcomInfo",com_id);
		} catch (Exception e) {
			System.out.println("DjAnnoDaoImpl의 annoList1에서 예외 발생!->"+e.getMessage());
		}
		
		return comp1;
	}

	@Override
	public List<Comm> mainCatList1() {
		System.out.println("DjAnnoDaoImpl의 mainCatList1 시작되었습니다.");
		List<Comm> mainCat001 = null;
		
		try {
			mainCat001 = session.selectList("DjJobTect1");
			
			
		} catch (Exception e) {
			System.out.println("DjAnnoDaoImpl의 mainCatList1에서 예외 발생!->"+e.getMessage());
		}
		
		
		
		return mainCat001;
	}

	@Override
	public List<Comm> mainCatList2() {
		System.out.println("DjAnnoDaoImpl의 mainCatList2 시작되었습니다.");
		List<Comm> mainCat002 = null;
		
		try {
			mainCat002 = session.selectList("DjJobTect2");
			
			
		} catch (Exception e) {
			System.out.println("DjAnnoDaoImpl의 mainCatList2에서 예외 발생!->"+e.getMessage());
		}
		
		
		
		return mainCat002;
	}

	@Override
	public List<Comm> mainCatList() {
		System.out.println("DjAnnoDaoImpl의 mainCatList 시작되었습니다.");
		List<Comm> mainCat = null;
		
		try {
			mainCat = session.selectList("DjJobTect");
			
			
		} catch (Exception e) {
			System.out.println("DjAnnoDaoImpl의 mainCatList에서 예외 발생!->"+e.getMessage());
		}
		
		
		
		return mainCat;
	}

	@Override
	public void annoWriting(Announce anno) {
			
			int answer11 = 0;
		
		try {
			answer11=session.insert("DjAnnoInsert", anno);
			System.out.println("다오에서 응답결과 확인");
			
			switch(answer11) {
			
			case 1: System.out.println("insert가 깔끔하게 완료되었습니다!"); break;
			default : System.out.println("insert에 문제가 생겼다오"); break;
			
			}
			
		} catch (Exception e) {
			System.out.println("DjAnnoDaoImpl의 annoWriting에서 예외 발생!"+e.getMessage());
		}
		
		
	}

	@Override
	public int insertComImg(Company comp) {
		System.out.println("DjAnnoDaoImpl의 insertComImg시작되었습니다.");
		
		int result = 0;
		try {
			System.out.println("1.다오 구현체에서 insertComImg  comp.getCom_id()->"+comp.getCom_id());
			System.out.println("2.다오 구현체에서 insertComImg comp.getCom_img()->"+comp.getCom_img());
			result = session.update("DjInsertComImg", comp);
			System.out.println("3.다오 구현체에서 insertComImg result->"+result);
			
		} catch (Exception e) {
			System.out.println("4. insertComImg에서 에러발생 ->"+e.getMessage());
		}
		
		System.out.println("5 다오 구현체에서 result->"+result);
		
		return result;
	}

	@Override
	public int imgDel(String imgpath11) {
		System.out.println("DjAnnoDaoImpl의 imgDel 시작되었습니다");
			
			int resultofDelete = 0;
		try {
			resultofDelete = session.delete("DjDeleteComImg", imgpath11);
		} catch (Exception e) {
			System.out.println("DjAnnoDaoImpl의 imgDel에서 예외가 발생했습니다."+e.getMessage());
		}
		System.out.println("resultofDelete->"+resultofDelete);
		
		return resultofDelete;
	}

	@Override
	public String nullconfirm(String comId1) {
		
		String IsitNull = null;
		try {
			IsitNull=session.selectOne("DjComImgConfirm", comId1);
			System.out.println("nullconfirm() 에서 IsitNull내용 확인->"+IsitNull);
		} catch (Exception e) {
			System.out.println("DjAnnoDaoImpl의 nullconfirm에서 예외가 발생했습니다."+e.getMessage());
		}
		System.out.println("nullconfirm() 에서 IsitNull내용 최종 확인->"+IsitNull);

		return IsitNull;
	}
	
	
}
