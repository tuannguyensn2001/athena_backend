# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SyncMemberToFollowerJob, type: :job do
  let!(:user) { FactoryBot.create(:user, role: :teacher) }
  let!(:workshop) { FactoryBot.create(:workshop) }
  let(:status) { :active }
  let!(:member) { FactoryBot.create(:member, user:, workshop:, role: :teacher, status:) }
  let!(:follower) { FactoryBot.create(:follower, user:, followable: workshop) }

  describe '#perform_later' do
    context 'delete member' do
      context 'has follower' do
        let!(:follower) { FactoryBot.create(:follower, user:, followable: workshop) }
        before do
          # member.delete
        end
        it 'delete follower' do
          member.delete
          expect { described_class.perform_later(member.attributes) }.to have_enqueued_job(described_class)
          expect { described_class.perform_now(member.attributes) }.to change { Follower.count }.by(-1)
        end
      end
    end

    context 'save member' do
      context 'status is pending' do
        let(:status) { :pending }
        it 'delete follower' do
          expect { described_class.perform_later(member.attributes) }.to have_enqueued_job(described_class)
          expect { described_class.perform_now(member.attributes) }.to change { Follower.count }.by(-1)
        end
      end

      context 'status is active' do
        context 'follower existed' do
          it 'not create follower' do
            expect { described_class.perform_later(member.attributes) }.to have_enqueued_job(described_class)
            expect { described_class.perform_now(member.attributes) }.to change { Follower.count }.by(0)
          end
        end

        context 'follower not existed' do
          before do
            follower.delete
          end
          it 'create follower' do
            expect { described_class.perform_later(member.attributes) }.to have_enqueued_job(described_class)
            expect { described_class.perform_now(member.attributes) }.to change { Follower.count }.by(1)
          end
        end
      end
    end
  end
end
