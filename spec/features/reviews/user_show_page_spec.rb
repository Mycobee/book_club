require 'rails_helper'

RSpec.describe "as a visitor" do
  describe 'when it visits the user show page' do
    it 'can see all the reviews for a user' do
      @book_1 = Book.create!(title: "In Search Of Lost Time", page_count: 4215, pub_year: 1913, thumbnail_url: 'https://images.penguinrandomhouse.com/cover/9780679645689')
      @book_2 = Book.create(title: "Don Quixote", page_count: 928, pub_year: 1605, thumbnail_url: "https://i.pinimg.com/originals/2e/42/d2/2e42d25ee87ad6bb5f512bd86e099233.jpg")
      @review_1 = @book_1.reviews.create(heading: "Great", score: 5, full_review: "Read this", username: "Tupac")
      @review_2 = @book_2.reviews.create(heading: "What?", score: 3, full_review: "I can't tell if this book is good or not", username: "Tupac")
      @review_3 = @book_2.reviews.create(heading: "Best Book", score: 5, full_review: "This was really something", username: "Jeremy")


      visit reviews_path(arg: @review_1.username)

      expect(page).to have_content(@review_1.username)
      expect(page).to_not have_content(@review_3.username)

      within "#review-#{@review_1.id}" do
        expect(page).to have_content(@review_1.heading)
        expect(page).to have_content(@review_1.score)
        expect(page).to have_content(@review_1.full_review)
        expect(page).to have_content(@review_1.created_at.to_date.to_s)
        expect(page).to have_xpath("//img[@src='https://images.penguinrandomhouse.com/cover/9780679645689']")


      end

      within "#review-#{@review_2.id}" do
        expect(page).to have_content(@review_2.heading)
        expect(page).to have_content(@review_2.score)
        expect(page).to have_content(@review_2.full_review)
        expect(page).to have_content(@review_1.created_at.to_date.to_s)
        expect(page).to have_xpath("//img[@src='https://i.pinimg.com/originals/2e/42/d2/2e42d25ee87ad6bb5f512bd86e099233.jpg']")


      end



    end

  end

end


# As a Visitor,
# When I click on a user's name for any book review
# I am taken to a show page for that user.
# I should see all reviews that this
# user has written.
# Each review shows:
# - the title of the review
# - the description of the review
# - the rating of the review
# - the title of the book
# - the thumbnail image for the book
# - the date the review was written
