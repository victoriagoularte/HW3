Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    rating = "ratings_#{rating}"
    if uncheck
      uncheck(rating)
    else
      check(rating)
    end
  end
end

Then /I should see all the movies/ do
  assert page.all("table#movies tr").size + 2 == Movie.count()
end

And /I check all ratings/ do
  rating_list = Movie.all_ratings
  rating_list.each do |rating|
    rating = "ratings_#{rating}"
    check(rating)
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  assert page.body.index(e1) < page.body.index(e2)
end
