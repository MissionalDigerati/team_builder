require 'spec_helper'

describe Task, :type => :model do
  context "incomplete_tasks method" do

    it "should return the current date" do
      expect(Task.current_date).to eq(Time.now.to_date)
    end

    it "should not return anything other than the current date" do
      expect(Task.current_date).not_to eq(1.weeks.from_now.to_date)
    end

    it "shoud return tomorrows date" do
      expect(Task.tomorrows_date).to eq(1.days.from_now.to_date)
    end

    it "shoud return the date one week from today" do
      expect(Task.next_weeks_date).to eq(1.weeks.from_now.to_date)
    end

    it "should return the date 4 weeks from today" do
      expect(Task.next_4_weeks_date).to eq(4.weeks.from_now.to_date)
    end

    it "should return the number that corresponds with the current day" do
      expect(Task.current_day_number).to eq(Time.now.day)
    end

    it "should return the number that corresponds with the current month" do
      expect(Task.current_month_number).to eq(Time.now.month)
    end

    it "should return the current year in number for as a string" do
      expect(Task.current_year).to eq(Time.now.year.to_s)
    end


  end
  
  context "validataions" do
    it "should create a valid task" do
      expect(FactoryGirl.build(:defaulted_task)).to be_valid
    end
    
    it "should require task" do
      expect(FactoryGirl.build(:defaulted_task, :task => "")).not_to be_valid
    end
    
    it "should require due_date" do
      expect(FactoryGirl.build(:defaulted_task, :due_date => nil)).not_to be_valid
    end
    
    it "should require category" do
      expect(FactoryGirl.build(:defaulted_task, :category => nil)).not_to be_valid
    end
    
    it "should require contact_id" do
      expect(FactoryGirl.build(:defaulted_task, :contact_id => nil)).not_to be_valid
    end
    
  end

  context "methods" do


    context "#total_tasks" do

        it "should return the correct # of completed tasks" do
            FactoryGirl.create(:defaulted_task, :completed => false, :task => "task1")
            FactoryGirl.create(:defaulted_task, :completed => true, :task => "task2")
            FactoryGirl.create(:defaulted_task, :completed => true, :task => "task3")
            expect(Task.total_tasks(:completed)).to eq(2)
        end

        it "should return the correct # of incomplete tasks" do
            FactoryGirl.create(:defaulted_task, :completed => false, :task => "task1")
            FactoryGirl.create(:defaulted_task, :completed => true, :task => "task2")
            FactoryGirl.create(:defaulted_task, :completed => true, :task => "task3")
            expect(Task.total_tasks(:incomplete)).to eq(1)
        end

        it "should return the correct # of all tasks by default" do
            FactoryGirl.create(:defaulted_task, :completed => false, :task => "task1")
            FactoryGirl.create(:defaulted_task, :completed => true, :task => "task2")
            FactoryGirl.create(:defaulted_task, :completed => true, :task => "task3")
            expect(Task.total_tasks).to eq(3)
        end

        it "should return the correct # of overdue tasks (ie. tasks overdue and incomplete)" do
            FactoryGirl.create(:defaulted_task, :completed => false, :task => "task1", :due_date => 1.month.ago)
            FactoryGirl.create(:defaulted_task, :completed => false, :task => "task4")
            FactoryGirl.create(:defaulted_task, :completed => false, :task => "task1", :due_date => 1.month.ago)
            FactoryGirl.create(:defaulted_task, :completed => true, :task => "task2")
            FactoryGirl.create(:defaulted_task, :completed => true, :task => "task3", :due_date => 1.month.ago)
            expect(Task.total_tasks(:overdue)).to eq(2)
        end

    end

    context "#is_overdue?" do

      it "should return true if the task is overdue" do
        task = FactoryGirl.create(:defaulted_task, :completed => false, :task => "task3", :due_date => 1.month.ago)
        expect(task.is_overdue?).to be === true
      end

      it "should return false if the task is not overdue" do
        task = FactoryGirl.create(:defaulted_task, :completed => false, :task => "task3", :due_date => 1.month.from_now)
        expect(task.is_overdue?).to be === false
      end

      it "should return false if the task is completed" do
        task = FactoryGirl.create(:defaulted_task, :completed => true, :task => "task3", :due_date => 1.month.ago)
        expect(task.is_overdue?).to be === false
      end
    end

    context "#is_completed?" do

        it "should return true if it is completed" do
            task = FactoryGirl.create(:defaulted_task, :completed => true, :task => "task3")
            expect(task.is_completed?).to be === true
        end

        it "should return false if it is incomplete" do
            task = FactoryGirl.create(:defaulted_task, :completed => false, :task => "task3")
            expect(task.is_completed?).to be === false
        end
    end

  end
end
