class TransportActivityEvidenceGenerator
  FONT_PATH = File.expand_path("~/Library/Fonts/DejaVuSans.ttf")

  EVIDENCE_MAX_SIZE = 1600
  THUMBNAIL_MAX_SIZE = 200

  def initialize(activity, uploaded_photo)
    @activity = activity
    @uploaded_photo = uploaded_photo
  end

  def call
    return unless @uploaded_photo.present?

    original_data = @uploaded_photo.read

    # ------------------------------------------------------------
    # 1. Evidence photo
    # ------------------------------------------------------------
    evidence_image = MiniMagick::Image.read(original_data)
    evidence_image.resize "#{EVIDENCE_MAX_SIZE}x#{EVIDENCE_MAX_SIZE}>"

    add_evidence_panel(evidence_image)

    evidence_file = Tempfile.new([ "transport-evidence", ".jpg" ])

    evidence_image.format "jpg"
    evidence_image.quality "88"
    evidence_image.write evidence_file.path

    @activity.evidence_photo.attach(
      io: File.open(evidence_file.path),
      filename: "transport-evidence-#{@activity.id}.jpg",
      content_type: "image/jpeg"
    )

    # ------------------------------------------------------------
    # 2. Thumbnail
    # ------------------------------------------------------------
    thumbnail_image = MiniMagick::Image.read(original_data)
    thumbnail_image.resize "#{THUMBNAIL_MAX_SIZE}x#{THUMBNAIL_MAX_SIZE}>"

    add_thumbnail_panel(thumbnail_image)

    thumbnail_file = Tempfile.new([ "transport-evidence-thumbnail", ".jpg" ])

    thumbnail_image.format "jpg"
    thumbnail_image.quality "82"
    thumbnail_image.write thumbnail_file.path

    @activity.evidence_thumbnail.attach(
      io: File.open(thumbnail_file.path),
      filename: "transport-evidence-thumbnail-#{@activity.id}.jpg",
      content_type: "image/jpeg"
    )
  ensure
    evidence_file&.close
    evidence_file&.unlink

    thumbnail_file&.close
    thumbnail_file&.unlink
  end

  private

  def evidence_text
    [
      "SPD TRANSPORT",
      "#{@activity.location.name} • #{@activity.transporter_action.name}",
      @activity.performed_at.strftime("%B %-d, %Y • %I:%M %p"),
      @activity.user.email_address
    ]
  end

  def add_evidence_panel(image)
    font_size = [ (image.width * 0.025).round, 18 ].max
    line_spacing = [ (font_size * 0.25).round, 4 ].max
    padding = [ (image.width * 0.025).round, 30 ].max

    panel_height = (font_size * 5.5).round + (padding * 2)

    original_height = image.height

    image.combine_options do |cmd|
      cmd.gravity "northwest"

      # Extend the canvas downward.
      cmd.background "black"
      cmd.extent "#{image.width}x#{original_height + panel_height}+0+0"
    end

    image.combine_options do |cmd|
      cmd.gravity "south"
      cmd.fill "white"
      cmd.pointsize font_size
      cmd.font FONT_PATH
      cmd.interline_spacing line_spacing
      cmd.draw "text #{padding},#{padding} '#{evidence_text.join("\n")}'"
    end
  end

  def add_thumbnail_panel(image)
    font_size = 7
    line_spacing = 1
    padding = 5

    panel_height = 35
    original_height = image.height

    image.combine_options do |cmd|
      cmd.gravity "northwest"
      cmd.background "black"
      cmd.extent "#{image.width}x#{original_height + panel_height}+0+0"
    end

    thumbnail_text = [
      "SPD TRANSPORT",
      "#{@activity.location.name} • #{@activity.transporter_action.name}",
      @activity.performed_at.strftime("%m/%d/%Y %I:%M %p")
    ].join("\n")

    image.combine_options do |cmd|
      cmd.gravity "south"
      cmd.fill "white"
      cmd.pointsize font_size
      cmd.font FONT_PATH
      cmd.interline_spacing line_spacing
      cmd.draw "text #{padding},#{padding} '#{thumbnail_text}'"
    end
  end
end
