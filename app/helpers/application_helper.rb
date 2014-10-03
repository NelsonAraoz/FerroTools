module ApplicationHelper
	def all_categories
		Category.where(:visible=>true).sort_by{|e| e[:nombre]}
	end
end
