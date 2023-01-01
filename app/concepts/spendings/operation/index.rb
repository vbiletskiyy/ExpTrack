module Spendings::Operation
  class Index < Trailblazer::Operation
    step :set_user_spendings
    step :filter_by_category
    step :filter_by_amount
    step :filter_by_description
    step :filtered

    def set_user_spendings(ctx, filter:, current_user:, **)
      ctx[:filtered] = current_user.spendings
      return ctx[:filtered] if filter
    end

    def filter_by_category(ctx, filter:, current_user:, **)      p '!!!'
      ctx[:filter_by_category] = Spending
        .where(user_id: current_user.id)
        .includes(:spending_category)
        .where(spending_categories: {title: filter.capitalize})
    end

    def filter_by_amount(ctx, filter:, current_user:, **)
      ctx[:filter_by_amount] = Spending.where(user_id: current_user.id, amount: filter)
    end

    def filter_by_description(ctx, filter:, current_user:, **)
      ctx[:filter_by_description] = Spending.where(user_id: current_user.id).where("LOWER(description) ILIKE ?", "%#{filter}%")
    end

    def filtered(ctx, filtered:, filter_by_amount:, filter_by_category:, filter_by_description:, **)
      ctx[:filtered] = 
        filter_by_amount.presence ||
        filter_by_category.presence ||
        filter_by_description.presence ||
        filtered
    end
  end
end
