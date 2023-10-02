document.addEventListener("turbolinks:load", function() {
  const $liveRecordSelector = $("#good_live_record_id");
  const $dateField = $("#good_date");
  const $artistSelector = $("#good_artist_id");
  const $addMemberLink = $("#add_member_link");
  const $memberSelector = $("#good_member_id");



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
          $addMemberLink.css('display', 'none');
          $memberSelector.html(`<option value="">-アーティストを選択してください-</option>`).prop("disabled", true);
        }
      }).fail(function(jqxhr, textStatus, error) {
        console.error("Request failed:", textStatus, error);
      });
    }
  });
});
