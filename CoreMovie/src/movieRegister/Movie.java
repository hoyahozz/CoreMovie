package movieRegister;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class Movie {
	
	private static String getTagValue(String tag, Element eElement) {
		NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		if (nValue == null)
			return null;
		return nValue.getNodeValue();
	}

	public String movieRank(int temp) {
		SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
		Calendar c1=new GregorianCalendar();
		c1.add(Calendar.DATE,-1);
		String yeDate=formatter.format(c1.getTime());
		try {
				String url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.xml?"
						+ "key=8eaa7e80de5bac465e8f6bc60181d486&targetDt="+yeDate;

				DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
				DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
				Document doc = dBuilder.parse(url);

				doc.getDocumentElement().normalize();
				//System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
				NodeList nList = doc.getElementsByTagName("dailyBoxOffice");
				
				//for (temp = 0; temp < nList.getLength(); temp++) {
					Node nNode = nList.item(temp);
					if (nNode.getNodeType() == Node.ELEMENT_NODE) {
						Element eElement = (Element) nNode;
						//System.out.println("영화제목 : " + getTagValue("movieNm", eElement));
						return getTagValue("movieNm",eElement);
					}
				//}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "데이터가 없습니다";
	}
	public String getCode(int temp) {
		
		SimpleDateFormat formatter=new SimpleDateFormat("yyyyMMdd");
		Calendar c1=new GregorianCalendar();
		c1.add(Calendar.DATE,-1);
		String yeDate=formatter.format(c1.getTime());
		try {
			String url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.xml?"
					+ "key=8eaa7e80de5bac465e8f6bc60181d486&targetDt="+yeDate;
			
			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
			Document doc = dBuilder.parse(url);
			doc.getDocumentElement().normalize();
			
			NodeList nList = doc.getElementsByTagName("dailyBoxOffice");
			Node nNode = nList.item(temp);
			if (nNode.getNodeType() == Node.ELEMENT_NODE) {
				Element eElement = (Element) nNode;
				
				return getTagValue("movieCd",eElement);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "데이터가 없습니다";
	}
	
	public String[] movieData(String mvCode){
		String data[]=new String[10];
		try {
			String url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.xml?"
					+ "key=8eaa7e80de5bac465e8f6bc60181d486&movieCd="+mvCode;

			
			DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
			Document doc = dBuilder.parse(url);
			Element root=doc.getDocumentElement();

			NodeList nList = doc.getElementsByTagName("movieInfo");
			Node nNode = nList.item(0);
			if (nNode.getNodeType() == Node.ELEMENT_NODE) {
				Element eElement = (Element) nNode;
				
				data[0]=getTagValue("movieNm",eElement);
				data[1]=getTagValue("movieNmEn",eElement);
				data[1]=data[1]+" , "+getTagValue("prdtYear",eElement);
				data[2]=getTagValue("showTm",eElement);
			}

			NodeList nList2 = doc.getElementsByTagName("genre");
			Node nNode1 = nList2.item(0);
			Node nNode2=nList2.item(1);
			if (nNode1.getNodeType() == Node.ELEMENT_NODE) {
				Element eElement = (Element) nNode1;
				Element eElement1 = (Element) nNode2;
				
				data[3]=getTagValue("genreNm",eElement);
				//data[4]=getTagValue("genreNm",eElement1);
			
			}
			
			NodeList nList3 = doc.getElementsByTagName("nations");
			Node nNode3=nList3.item(0);
			if (nNode3.getNodeType() == Node.ELEMENT_NODE) {
				Element eElement = (Element) nNode3;
				data[4]=getTagValue("nationNm",eElement);
			}
			NodeList nList4 = doc.getElementsByTagName("director");
			Node nNode4=nList4.item(0);
			if (nNode4.getNodeType() == Node.ELEMENT_NODE) {
				Element eElement = (Element) nNode4;
				data[5]=getTagValue("peopleNm",eElement);
			}
			
			
			NodeList nList5 = doc.getElementsByTagName("actor");
			Node nNode5 = nList5.item(0);
			Node nNode6=nList5.item(1);
			Node nNode7=nList5.item(2);
			if (nNode5.getNodeType() == Node.ELEMENT_NODE) {
				Element eElement = (Element) nNode5;
				Element eElement1 = (Element) nNode6;
				
				data[6]=getTagValue("peopleNm",eElement);
				data[7]=", "+getTagValue("peopleNm",eElement1);
				
			}
			
			NodeList nList6 = doc.getElementsByTagName("audit");
			Node nNode8=nList6.item(0);
			if (nNode8.getNodeType() == Node.ELEMENT_NODE) {
				Element eElement = (Element) nNode8;
				data[8]=getTagValue("watchGradeNm",eElement);
			}
						
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return data;
	}
}
