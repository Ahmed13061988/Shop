module ReviewsHelper
    def display_header(review)
        if params[:shop_id]
            content_tag(:h1, "Add a Review for #{review.shop.name} -  #{review.shop.category.name}")
        else
          content_tag(:h1, "Create a review")
        end
      end
end
