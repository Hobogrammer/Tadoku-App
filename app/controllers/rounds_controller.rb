class RoundsController < ApplicationController
        include ApplicationHelper
        include SessionsHelper
        before_filter :signed_in_user, only: :create
        before_filter :admin_user, only: [:destroy, :edit]


        def index
                @entrants = Round.includes(:user).where(:round_id => "#{ApplicationHelper::curr_round}")
                if @entrants == nil
                        redirect_to root_url, :flash => { :error => "There are currently no users registered for this round." }
                end
                
                if signed_in?
                        @update = current_user.updates.build
                end
        end

        def create
                if current_user.rounds.find_by_round_id(ApplicationHelper::curr_round) != nil
                        redirect_to root_url, :flash => { :error => "You are already registered for the Contest"}
                else
                        @reg = current_user.rounds.build(params[:round])
                        @reg.pcount = '0'
                        if @reg.save
                                redirect_to root_url, :flash => { :success => "You have successfully registered for the Tadoku contest" }
                        end
            	end
        end

        def show
          @entrants = Round.includes(:user).where(:round_id => params[:id])
         #@entrants = Round.includes(:user).find_all_by_round_id(params[:round_id])
          @roundid = params[:id]
          if signed_in?
                        @update = current_user.updates.build
           end

           if @entrants == nil
                        redirect_to root_url, :flash => { :error => "There are currently no users registered for this round." }
            end
        end

        def lang_show
            @entrants = Round.includes(:user).where("round_id = ? and (lang1 = ? or lang2 = ? or lang3 = ?)", params[:round_id], params[:lang], params[:lang], params[:lang])

             @roundid = params[:id]
          if signed_in?
                        @update = current_user.updates.build
           end

           if @entrants == nil
                        redirect_to root_url, :flash => { :error => "There are currently no users registered for this round." }
            end
        end

        def round0_show
            @entrants = Round.includes(:user).where(:round_id => 201008)
        end

        private
        
                def admin_user
                        redirect_to(root_path) unless current_user.admin?
                end
end