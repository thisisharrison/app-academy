class ChangeTagColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :taggings, :tag_id, :tag_topic_id
  end
end

# ALTER TABLE "taggings" RENAME COLUMN "tag_id" TO "tag_topic_id"
# ALTER INDEX "index_taggings_on_tag_id_and_shortened_url_id" RENAME TO "index_taggings_on_tag_topic_id_and_shortened_url_id"