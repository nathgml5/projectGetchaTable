package com.hago.getchaTable.review.config;

public class AvgPointCon {
	public static String getAvgPoint(int[] points) {
		double result = 0;
		int total = 0;
		
		for(int p : points) {
			total += p;
		}
		
		int count = points.length;
		
		result = total / (double)count;
		System.out.println(result);
		 
		return String.format("%.1f", result); //소수점 둘째자리에서 반올림
	}
}
