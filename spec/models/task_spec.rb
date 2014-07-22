require 'spec_helper'

describe Task, :type => :model do
  
  context "validataions" do
    it "should create a valid task" do
      expect(FactoryGirl.build(:defaulted_task)).to be_valid
    end
    
    it "should require task" do
      expect(FactoryGirl.build(:defaulted_task, task: nil)).not_to be_valid
    end
    
    it "should require due_date" do
      expect(FactoryGirl.build(:defaulted_task, due_date: nil)).not_to be_valid
    end
    
    it "should require category" do
      expect(FactoryGirl.build(:defaulted_task, category: nil)).not_to be_valid
    end
    
    it "should require contact_id" do
      expect(FactoryGirl.build(:defaulted_task, contact_id: nil)).not_to be_valid
    end
    
  end

  context "scopes" do

    context "#one_week_from_today" do

      it "should return all tasks for the today and 6 days after" do
        FactoryGirl.create(:defaulted_task, completed: false, task: "task1", due_date: Date.today)
        FactoryGirl.create(:defaulted_task, completed: false, task: "task2", due_date: 1.day.from_now.to_date)
        FactoryGirl.create(:defaulted_task, completed: false, task: "task3", due_date: 1.week.from_now.to_date)
        FactoryGirl.create(:defaulted_task, completed: false, task: "task4", due_date: 2.weeks.from_now.to_date)
        results = Task.one_week_from_today
        expect(results.count).to eq(3)
        results.each do |t|
          expect(t.task).not_to eq('task4')
        end
      end

    end

    context "#one_month_from_today" do

      it "should return all tasks for today and 1 month from today" do
        FactoryGirl.create(:defaulted_task, completed: false, task: "task1", due_date: Date.today)
        FactoryGirl.create(:defaulted_task, completed: false, task: "task2", due_date: 1.day.from_now.to_date)
        FactoryGirl.create(:defaulted_task, completed: false, task: "task3", due_date: 1.week.from_now.to_date)
        FactoryGirl.create(:defaulted_task, completed: false, task: "task4", due_date: 3.weeks.from_now.to_date)
        FactoryGirl.create(:defaulted_task, completed: false, task: "task5", due_date: 5.weeks.from_now.to_date)
        results = Task.one_month_from_today
        expect(results.count).to eq(4)
        results.each do |t|
          expect(t.task).not_to eq('task5')
        end
      end

    end

    context "#overdue" do

      it "should return all overdue tasks" do
        FactoryGirl.create(:defaulted_task, completed: false, task: "task1", due_date: 2.days.ago.to_date)
        FactoryGirl.create(:defaulted_task, completed: false, task: "task2", due_date: 5.days.ago.to_date)
        FactoryGirl.create(:defaulted_task, completed: false, task: "task3", due_date: 1.week.ago.to_date)
        FactoryGirl.create(:defaulted_task, completed: false, task: "task3b", due_date: 2.weeks.ago.to_date)
        FactoryGirl.create(:defaulted_task, completed: false, task: "task4", due_date: 10.days.from_now.to_date)
        results = Task.overdue
        expect(results.count).to eq(4)
        results.each do |t|
          expect(t.task).not_to eq('task4')
        end
      end

    end

  end

  context "methods" do


    context "#total_tasks" do

        it "should return the correct # of completed tasks" do
            FactoryGirl.create(:defaulted_task, completed: false, task: "task1")
            FactoryGirl.create(:defaulted_task, completed: true,  task: "task2")
            FactoryGirl.create(:defaulted_task, completed: true,  task: "task3")
            expect(Task.total_tasks(:completed)).to eq(2)
        end

        it "should return the correct # of incomplete tasks" do
            FactoryGirl.create(:defaulted_task, completed: false, task: "task1")
            FactoryGirl.create(:defaulted_task, completed: true,  task: "task2")
            FactoryGirl.create(:defaulted_task, completed: true,  task: "task3")
            expect(Task.total_tasks(:incomplete)).to eq(1)
        end

        it "should return the correct # of all tasks by default" do
            FactoryGirl.create(:defaulted_task, completed: false, task: "task1")
            FactoryGirl.create(:defaulted_task, completed: true,  task: "task2")
            FactoryGirl.create(:defaulted_task, completed: true,  task: "task3")
            expect(Task.total_tasks).to eq(3)
        end

        it "should return the correct # of overdue tasks (ie. tasks overdue and incomplete)" do
            FactoryGirl.create(:defaulted_task, completed: false, task: "task1", due_date: 1.month.ago.to_date)
            FactoryGirl.create(:defaulted_task, completed: false, task: "task4")
            FactoryGirl.create(:defaulted_task, completed: false, task: "task1", due_date: 1.month.ago.to_date)
            FactoryGirl.create(:defaulted_task, completed: true,  task: "task2")
            FactoryGirl.create(:defaulted_task, completed: true,  task: "task3", due_date: 1.month.ago.to_date)
            expect(Task.total_tasks(:overdue)).to eq(2)
        end

    end

    context "#is_overdue?" do

      it "should return true if the task is overdue" do
        task = FactoryGirl.create(:defaulted_task, completed: false, task: "task3", due_date: 1.month.ago.to_date)
        expect(task.is_overdue?).to be === true
      end

      it "should return false if the task is not overdue" do
        task = FactoryGirl.create(:defaulted_task, completed: false, task: "task3", due_date: 1.month.from_now.to_date)
        expect(task.is_overdue?).to be === false
      end

      it "should return false if the task is completed" do
        task = FactoryGirl.create(:defaulted_task, completed: true, task: "task3", due_date: 1.month.ago.to_date)
        expect(task.is_overdue?).to be === false
      end
    end

    context "#is_completed?" do

        it "should return true if it is completed" do
            task = FactoryGirl.create(:defaulted_task, completed: true)
            expect(task.is_completed?).to be === true
        end

        it "should return false if it is incomplete" do
            task = FactoryGirl.create(:defaulted_task, completed: false)
            expect(task.is_completed?).to be === false
        end
    end

  end
end
