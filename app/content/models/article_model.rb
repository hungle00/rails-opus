class ArticleModel < Sitepress::Model
  collection glob: "articles/*.html*"
  data :title, :published, :description, :tags
end
