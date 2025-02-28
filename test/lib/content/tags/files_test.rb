# frozen_string_literal: true

require_relative '../../../test_helper'

class ContentTagsFilesTest < ActiveSupport::TestCase
  delegate :rails_blob_path, to: 'Rails.application.routes.url_helpers'

  setup do
    @page = occams_cms_pages(:default)
  end

  # -- Tests -------------------------------------------------------------------

  def test_init
    tag = Occams::Content::Tag::Files.new(context: @page, params: ['test'])
    assert_equal 'test',  tag.identifier
    assert_equal 'url',   tag.as
  end

  def test_init_with_params
    tag = Occams::Content::Tag::Files.new(
      context: @page,
      params: ['test', {
        'as' => 'image',
        'resize' => '100x100',
        'gravity' => 'center',
        'crop' => '100x100+0+0'
      }]
    )
    assert_equal 'test',  tag.identifier
    assert_equal 'image', tag.as
    assert_equal ({
      'resize' => '100x100',
      'gravity' => 'center',
      'crop' => '100x100+0+0'
    }), tag.variant_attrs
  end

  def test_content
    frag = @page.fragments.create!(
      identifier: 'test'
    )
    frag.update_attribute(:tag, 'files')
    frag.update_attribute(:files, fixture_file_upload('image.jpg', 'image/jpeg'))
    tag = Occams::Content::Tag::Files.new(context: @page, params: [frag.identifier])
    out = frag.attachments.map { |a| rails_blob_path(a, only_path: true) }.join(' ')
    assert_equal out, tag.content
  end

  def test_content_no_attachments
    tag = Occams::Content::Tag::Files.new(context: @page, params: ['test'])
    assert_equal '', tag.content
  end
end
