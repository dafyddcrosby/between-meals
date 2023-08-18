# vim: syntax=ruby:expandtab:shiftwidth=2:softtabstop=2:tabstop=2

# Copyright 2013-present Facebook
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'logger'
require 'between_meals/repo'
require 'between_meals/repo/hg'

describe 'BetweenMeals::Repo' do
  let(:logger) do
    Logger.new('/dev/null')
  end

  context "loads Hg class" do
    before(:each) do
      allow_any_instance_of(BetweenMeals::Repo::Hg).to receive(:exists?).and_return(true)
    end
    it 'loads and uses Repo::Hg before loading Repo::Git' do
      allow(File).to receive(:directory?).and_call_original
      allow(File).to receive(:directory?).with('fake').and_return(true)
      r = BetweenMeals::Repo.get('auto', 'fake', logger)
      expect(r.class).to eq(BetweenMeals::Repo::Hg)
      expect(BetweenMeals::Repo::Git).to eq(nil)
    end
  end
end
