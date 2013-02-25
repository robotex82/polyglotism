require 'spec_helper'
load File.expand_path("../../dummy/db/migrate/20130219153813_create_posts.rb", __FILE__)

describe CreatePosts do
  before do
    @my_migration_version = 20130219153813
    @previous_migration_version = 0
    @migrations_path = File.expand_path("../../dummy/db/migrate", __FILE__)
  end # before

  describe '.up' do
    before do
      ActiveRecord::Migrator.migrate(@migrations_path, @previous_migration_version)
      puts "Testing up migration for #{@my_migration_version} - resetting to #{ActiveRecord::Migrator.current_version}";
      ActiveRecord::Migrator.migrate(@migrations_path, @my_migration_version)
      Post.reset_column_information
    end # before

    it 'should create a table for posts' do
      Post.table_exists?.should eq(true)
    end # it

    it 'should create translated body columns' do
      I18n.available_locales.each do |locale|
        Post.columns_hash.keys.should include("body_#{locale}")
      end
    end # it
  end # describe '.up'

  describe '.down' do
  end # describe '.down'
  
  after(:all) do
    # Return to latest state
    ActiveRecord::Migrator.migrate(@migrations_path);
  end
end # describe CreatePosts

