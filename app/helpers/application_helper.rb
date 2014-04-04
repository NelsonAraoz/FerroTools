module ApplicationHelper
	def all_categories
		Category.all.sort_by{|e| e[:nombre]}
	end
end
