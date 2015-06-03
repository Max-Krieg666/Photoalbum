module UserUsergroupsHelper
  def select_user(user, selected = nil)
    select_tag(user, options_for_select(
      Owner.order('login').load.map{ |x| [x.login, x.id] } + [['', nil]],
        [selected]))
  end
end
