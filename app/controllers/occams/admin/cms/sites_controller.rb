# frozen_string_literal: true

class Occams::Admin::Cms::SitesController < Occams::Admin::Cms::BaseController

  skip_before_action  :load_admin_site,
                      :load_seeds

  before_action :build_site,  only: %i[new create]
  before_action :load_site,   only: %i[edit update destroy]
  before_action :authorize

  def index
    return redirect_to action: :new if ::Occams::Cms::Site.count.zero?
    @site   = ::Occams::Cms::Site.find_by_id(session[:site_id])
    @sites  = ::Occams::Cms::Site.all
  end

  def new
    render
  end

  def edit
    render
  end

  def create
    @site.save!
    flash[:success] = I18n.t("occams.admin.cms.sites.created")
    redirect_to occams_admin_cms_site_layouts_path(@site)
  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = I18n.t("occams.admin.cms.sites.creation_failure")
    render action: :new
  end

  def update
    @site.update!(site_params)
    flash[:success] = I18n.t("occams.admin.cms.sites.updated")
    redirect_to action: :edit, id: @site
  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = I18n.t("occams.admin.cms.sites.update_failure")
    render action: :edit
  end

  def destroy
    @site.destroy
    flash[:success] = I18n.t("occams.admin.cms.sites.deleted")
    redirect_to action: :index
  end

protected

  def build_site
    @site = ::Occams::Cms::Site.new(site_params)
    @site.hostname ||= request.host.downcase
  end

  def load_site
    @site = ::Occams::Cms::Site.find(params[:id])
    I18n.locale = Occams.config.admin_locale || @site.locale
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = I18n.t("occams.admin.cms.sites.not_found")
    redirect_to action: :index
  end

  def site_params
    params.fetch(:site, {}).permit!
  end

end
