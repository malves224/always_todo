require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  before do
    set_current_user
  end

  let!(:task) { create(:task, user: Current.user) }
  let(:valid_token) { JsonWebToken.encode({ id: Current.user.id }) }
  let(:headers) { { 'Authorization' => "Bearer #{valid_token}" } }

  describe 'GET /tasks' do
    it 'returns a 200 status code and all tasks' do
      get '/tasks', headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq([task.as_json])
    end
  end

  describe 'GET /tasks/:id' do
    it 'returns a 200 status code and the task' do
      get "/tasks/#{task.id}", headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(task.as_json)
    end

    context 'when the task does not exist' do
      it 'returns a 404 status code' do
        get '/tasks/0', headers: headers
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq('errors' => [I18n.t('activerecord.errors.models.task.record_not_found')])
      end
    end
  end

  describe 'POST /tasks' do
    let(:task_params) { attributes_for(:task) }

    context 'with valid parameters' do
      before { set_current_user }
      it 'creates a new task' do
        expect {
          post '/tasks', params: { task: task_params }, headers: headers
        }.to change(Task.unscoped, :count).by(1)
      end

      it 'returns a created status' do
        post '/tasks', params: { task: task_params }, headers: headers
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new task' do
        expect {
          post '/tasks', params: { task: { title: '' } }, headers: headers
        }.to change(Task.unscoped, :count).by(0)
      end

      it 'returns an unprocessable entity status' do
        post '/tasks', params: { task: { title: '' } }, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors'][0]).to eq('Title O título da tarefa é obrigatório')
      end
    end
  end

  describe 'PUT /tasks/:id' do
    let(:task_params) { attributes_for(:task) }

    context 'with valid parameters' do
      it 'updates the task' do
        put "/tasks/#{task.id}", params: { task: task_params }, headers: headers
        expect(task.reload.title).to eq(task_params[:title])
      end

      it 'returns a 200 status code' do
        put "/tasks/#{task.id}", params: { task: task_params }, headers: headers
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      it 'does not update the task' do
        put "/tasks/#{task.id}", params: { task: { title: '' } }, headers: headers
        expect(task.reload.title).not_to eq('')
      end

      it 'returns an unprocessable entity status' do
        put "/tasks/#{task.id}", params: { task: { title: '' } }, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors'][0]).to eq('Title O título da tarefa é obrigatório')
      end
    end

    context 'when the task belongs to another user' do
      it 'returns status code 403' do
        task = create(:task, user: create(:user))
        put "/tasks/#{task.id}", params: { task: task_params }, headers: headers
        expect(response).to have_http_status(:forbidden)
        expect(JSON.parse(response.body)).to eq('errors' => [I18n.t('tasks_controller.errors.unpermitted_task')])
      end
    end
  end

  describe 'DELETE /tasks/:id' do
    it 'deletes the task' do
      delete "/tasks/#{task.id}", headers: headers
      expect { task.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'returns a 204 status code' do
      delete "/tasks/#{task.id}", headers: headers
      expect(response).to have_http_status(:no_content)
    end

    context 'when the task belongs to another user' do
      it 'returns status code 403' do
        task = create(:task, user: create(:user))
        delete "/tasks/#{task.id}", headers: headers
        expect(response).to have_http_status(:forbidden)
        expect(JSON.parse(response.body)).to eq('errors' => [I18n.t('tasks_controller.errors.unpermitted_task')])
      end
    end
  end
end
