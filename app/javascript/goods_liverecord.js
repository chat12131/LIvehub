document.addEventListener("turbolinks:load", function() {
  const $liveRecordSelector = $("#good_live_record_id");
  const $dateField = $("#good_date");
  const $artistSelector = $("#good_artist_id");

  $liveRecordSelector.on("change", function() {
    const liveRecordId = $(this).val();

    if (liveRecordId) {
      $.getJSON(`/live_records/${liveRecordId}/details.json`, function(data) {
        if (data.date) {
          $dateField.val(data.date);
        } else {
          $dateField.val('');
        }

        if (data.artist && data.artist.id) {
          $artistSelector.val(data.artist.id).trigger("change");
        } else {
          $artistSelector.val('');
        }
      }).fail(function(jqxhr, textStatus, error) {
        console.error("Request failed:", textStatus, error);
      });
    }
  });
});
