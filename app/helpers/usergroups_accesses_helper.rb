module UsergroupsAccessesHelper
  def select_group(group, selected = nil)
    select_tag(group, options_for_select(
      Usergroup.where(owner_id: @current_owner.id).order('name').load.map{ |x| [x.name, x.id] },
        [selected]))
  end
end
