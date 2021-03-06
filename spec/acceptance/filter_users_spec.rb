require 'rails_helper'

RSpec.feature 'Filter users by cohort' do
  scenario 'by selecting cohort from dropdown', js: true do
    cohort   = create(:cohort, name: "1606")
    cohort_2 = create(:cohort, name: "1608")
    create(:enrolled_user, cohort_id: cohort.id)
    user = create(:enrolled_user, cohort_id: cohort_2.id)

    login(user)
    visit '/users'

    expect(page).to have_css("tr", count: 3)
    find("option[value='#{cohort.id}']").select_option

    expect(page).to have_content("1606")
    expect(page).to have_css("tr", count: 2)
  end
end
