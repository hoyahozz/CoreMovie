package review.movie;

public class ReviewList {
	private int movieIndex;
	private double movieScore;
	private double total;
	private String userId;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	public int getMovieIndex() {
		return movieIndex;
	}
	public void setMovieIndex(int movieIndex) {
		this.movieIndex = movieIndex;
	}
	public double getMovieScore() {
		return movieScore;
	}
	public void setMovieScore(double movieScore) {
		this.movieScore = movieScore;
	}
}
