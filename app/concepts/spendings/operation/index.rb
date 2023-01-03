module Spendings::Operation
  class Index < Trailblazer::Operation
    step :set_user_spendings
    step :filter_by_category
    step :filter_by_amount
    step :filter_by_description
    step :filtered

    def set_user_spendings(ctx, filter:, current_user:, **)
      ctx[:user_spendings] = Spending.includes(:user_spendings).where(user_spendings: {user_id: current_user.id, sent_by: nil})

      return ctx[:user_spendings] if filter
    end

    def filter_by_category(ctx, filter:, user_spendings:, **)
      ctx[:filter_by_category] = 
        filtered
          .includes(:spending_category)
          .where(spending_categories: {title: filter&.capitalize})
    end

    def filter_by_amount(ctx, filter:, user_spendings:, **)
      ctx[:filter_by_amount] = user_spendings.where(amount: filter)
    end

    def filter_by_description(ctx, filter:, user_spendings:, **)
      ctx[:filter_by_description] = user_spendings.where("LOWER(description) ILIKE ?", "%#{filter}%")
    end

    def filtered(ctx, user_spendings:, filter_by_amount:, filter_by_category:, filter_by_description:, **)
      ctx[:user_spendings] = 
        filter_by_amount.presence ||
        filter_by_category.presence ||
        filter_by_description
    end
  end
end
