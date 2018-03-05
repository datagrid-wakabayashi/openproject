#-- encoding: UTF-8

#-- copyright
# OpenProject is a project management system.
# Copyright (C) 2012-2018 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2017 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See docs/COPYRIGHT.rdoc for more details.
#++

require_relative 'tables/work_packages'
require_relative 'tables/users'

# This migration aggregates a set of former migrations
class ToV710AggregatedMigrations < ActiveRecord::Migration[5.1]
  class IncompleteMigrationsError < ::StandardError
  end

  @migrations_to_3_0 = <<-MIGRATIONS
    001_setup.rb
    002_issue_move.rb
    003_issue_add_note.rb
    004_export_pdf.rb
    005_issue_start_date.rb
    006_calendar_and_activity.rb
    007_create_journals.rb
    008_create_user_preferences.rb
    009_add_hide_mail_pref.rb
    010_create_comments.rb
    011_add_news_comments_count.rb
    012_add_comments_permissions.rb
    013_create_queries.rb
    014_add_queries_permissions.rb
    015_create_repositories.rb
    016_add_repositories_permissions.rb
    017_create_settings.rb
    018_set_doc_and_files_notifications.rb
    019_add_issue_status_position.rb
    020_add_role_position.rb
    021_add_tracker_position.rb
    022_serialize_possibles_values.rb
    023_add_tracker_is_in_roadmap.rb
    024_add_roadmap_permission.rb
    025_add_search_permission.rb
    026_add_repository_login_and_password.rb
    027_create_wikis.rb
    028_create_wiki_pages.rb
    029_create_wiki_contents.rb
    030_add_projects_feeds_permissions.rb
    031_add_repository_root_url.rb
    032_create_time_entries.rb
    033_add_timelog_permissions.rb
    034_create_changesets.rb
    035_create_changes.rb
    036_add_changeset_commit_date.rb
    037_add_project_identifier.rb
    038_add_custom_field_is_filter.rb
    039_create_watchers.rb
    040_create_changesets_issues.rb
    041_rename_comment_to_comments.rb
    042_create_issue_relations.rb
    043_add_relations_permissions.rb
    044_set_language_length_to_five.rb
    045_create_boards.rb
    046_create_messages.rb
    047_add_boards_permissions.rb
    048_allow_null_version_effective_date.rb
    049_add_wiki_destroy_page_permission.rb
    050_add_wiki_attachments_permissions.rb
    051_add_project_status.rb
    052_add_changes_revision.rb
    053_add_changes_branch.rb
    054_add_changesets_scmid.rb
    055_add_repositories_type.rb
    056_add_repositories_changes_permission.rb
    057_add_versions_wiki_page_title.rb
    058_add_issue_categories_assigned_to_id.rb
    059_add_roles_assignable.rb
    060_change_changesets_committer_limit.rb
    061_add_roles_builtin.rb
    062_insert_builtin_roles.rb
    063_add_roles_permissions.rb
    064_drop_permissions.rb
    065_add_settings_updated_on.rb
    066_add_custom_value_customized_index.rb
    067_create_wiki_redirects.rb
    068_create_enabled_modules.rb
    069_add_issues_estimated_hours.rb
    070_change_attachments_content_type_limit.rb
    071_add_queries_column_names.rb
    072_add_enumerations_position.rb
    073_add_enumerations_is_default.rb
    074_add_auth_sources_tls.rb
    075_add_members_mail_notification.rb
    076_allow_null_position.rb
    077_remove_issue_statuses_html_color.rb
    078_add_custom_fields_position.rb
    079_add_user_preferences_time_zone.rb
    080_add_users_type.rb
    081_create_projects_trackers.rb
    082_add_messages_locked.rb
    083_add_messages_sticky.rb
    084_change_auth_sources_account_limit.rb
    085_add_role_tracker_old_status_index_to_workflows.rb
    086_add_custom_fields_searchable.rb
    087_change_projects_description_to_text.rb
    088_add_custom_fields_default_value.rb
    089_add_attachments_description.rb
    090_change_versions_name_limit.rb
    091_change_changesets_revision_to_string.rb
    092_change_changes_from_revision_to_string.rb
    093_add_wiki_pages_protected.rb
    094_change_projects_homepage_limit.rb
    095_add_wiki_pages_parent_id.rb
    096_add_commit_access_permission.rb
    097_add_view_wiki_edits_permission.rb
    098_set_topic_authors_as_watchers.rb
    099_add_delete_wiki_pages_attachments_permission.rb
    100_add_changesets_user_id.rb
    101_populate_changesets_user_id.rb
    102_add_custom_fields_editable.rb
    103_set_custom_fields_editable.rb
    104_add_projects_lft_and_rgt.rb
    105_build_projects_tree.rb
    106_remove_projects_projects_count.rb
    107_add_open_id_authentication_tables.rb
    108_add_identity_url_to_users.rb
    20090214190337_add_watchers_user_id_type_index.rb
    20090312172426_add_queries_sort_criteria.rb
    20090312194159_add_projects_trackers_unique_index.rb
    20090318181151_extend_settings_name.rb
    20090323224724_add_type_to_enumerations.rb
    20090401221305_update_enumerations_to_sti.rb
    20090401231134_add_active_field_to_enumerations.rb
    20090403001910_add_project_to_enumerations.rb
    20090406161854_add_parent_id_to_enumerations.rb
    20090425161243_add_queries_group_by.rb
    20090503121501_create_member_roles.rb
    20090503121505_populate_member_roles.rb
    20090503121510_drop_members_role_id.rb
    20090614091200_fix_messages_sticky_null.rb
    20090704172350_populate_users_type.rb
    20090704172355_create_groups_users.rb
    20090704172358_add_member_roles_inherited_from.rb
    20091010093521_fix_users_custom_values.rb
    20091017212227_add_missing_indexes_to_workflows.rb
    20091017212457_add_missing_indexes_to_custom_fields_projects.rb
    20091017212644_add_missing_indexes_to_messages.rb
    20091017212938_add_missing_indexes_to_repositories.rb
    20091017213027_add_missing_indexes_to_comments.rb
    20091017213113_add_missing_indexes_to_enumerations.rb
    20091017213151_add_missing_indexes_to_wiki_pages.rb
    20091017213228_add_missing_indexes_to_watchers.rb
    20091017213257_add_missing_indexes_to_auth_sources.rb
    20091017213332_add_missing_indexes_to_documents.rb
    20091017213444_add_missing_indexes_to_tokens.rb
    20091017213536_add_missing_indexes_to_changesets.rb
    20091017213642_add_missing_indexes_to_issue_categories.rb
    20091017213716_add_missing_indexes_to_member_roles.rb
    20091017213757_add_missing_indexes_to_boards.rb
    20091017213835_add_missing_indexes_to_user_preferences.rb
    20091017213910_add_missing_indexes_to_issues.rb
    20091017214015_add_missing_indexes_to_members.rb
    20091017214107_add_missing_indexes_to_custom_fields.rb
    20091017214136_add_missing_indexes_to_queries.rb
    20091017214236_add_missing_indexes_to_time_entries.rb
    20091017214308_add_missing_indexes_to_news.rb
    20091017214336_add_missing_indexes_to_users.rb
    20091017214406_add_missing_indexes_to_attachments.rb
    20091017214440_add_missing_indexes_to_wiki_contents.rb
    20091017214519_add_missing_indexes_to_custom_values.rb
    20091017214611_add_missing_indexes_to_journals.rb
    20091017214644_add_missing_indexes_to_issue_relations.rb
    20091017214720_add_missing_indexes_to_wiki_redirects.rb
    20091017214750_add_missing_indexes_to_custom_fields_trackers.rb
    20091025163651_add_activity_indexes.rb
    20091108092559_add_versions_status.rb
    20091114105931_add_view_issues_permission.rb
    20091123212029_add_default_done_ratio_to_issue_status.rb
    20091205124427_add_versions_sharing.rb
    20091220183509_add_lft_and_rgt_indexes_to_projects.rb
    20091220183727_add_index_to_settings_name.rb
    20091220184736_add_indexes_to_issue_status.rb
    20091225164732_remove_enumerations_opt.rb
    20091227112908_change_wiki_contents_text_limit.rb
    20100129193402_change_users_mail_notification_to_string.rb
    20100129193813_update_mail_notification_values.rb
    20100221100219_add_index_on_changesets_scmid.rb
    20100313132032_add_issues_nested_sets_columns.rb
    20100313171051_add_index_on_issues_nested_set.rb
    20100705164950_change_changes_path_length_limit.rb
    20100714111651_prepare_journals_for_acts_as_journalized.rb
    20100714111652_update_journals_for_acts_as_journalized.rb
    20100714111653_build_initial_journals_for_acts_as_journalized.rb
    20100714111654_add_changes_from_journal_details_for_acts_as_journalized.rb
    20100804112053_merge_wiki_versions_with_journals.rb
    20100819172912_enable_calendar_and_gantt_modules_where_appropriate.rb
    20101104182107_add_unique_index_on_members.rb
    20101107130441_add_custom_fields_visible.rb
    20101114115114_change_projects_name_limit.rb
    20101114115359_change_projects_identifier_limit.rb
    20110220160626_add_workflows_assignee_and_author.rb
    20110223180944_add_users_salt.rb
    20110223180953_salt_user_passwords.rb
    20110224000000_add_repositories_path_encoding.rb
    20110226120112_change_repositories_password_limit.rb
    20110226120132_change_auth_sources_account_password_limit.rb
    20110227125750_change_journal_details_values_to_text.rb
    20110228000000_add_repositories_log_encoding.rb
    20110228000100_copy_repositories_log_encoding.rb
    20110314014400_add_start_date_to_versions.rb
    20110401192910_add_index_to_users_type.rb
    20110519194936_remove_comments_from_wiki_content.rb
    20110729125454_remove_double_initial_wiki_content_journals.rb
  MIGRATIONS

  @migrations_to_7_1 = <<-MIGRATIONS
    0_aggregated_migrations.rb
    20110211160100_add_summary_to_projects.rb
    20110817142220_add_display_sums_field_to_migration.rb
    20111114124552_add_user_first_logged_in_and_impaired_fields.rb
    20120319095930_localize_email_header_and_footer.rb
    20120319135006_add_custom_field_translation_table.rb
    20120529090411_create_delayed_jobs.rb
    20120731091543_use_the_full_sti_class_names_for_repositories.rb
    20120731135140_create_wiki_menu_items.rb
    20120802152122_rename_auth_source_ldap.rb
    20120809131659_create_wiki_menu_item_for_existing_wikis.rb
    20120828171423_make_groups_users_a_model.rb
    20121004054229_add_wiki_list_attachments.rb
    20121030111651_rename_acts_as_journalized_changes_column.rb
    20121101111303_add_missing_indexes_on_wiki_menu_items.rb
    20121114100641_aggregated_announcements_migrations.rb
    20130204140624_add_index_on_identifier_to_projects.rb
    20130315124655_add_longer_login_to_users.rb
    20130325165622_remove_gantt_related_data_from_database.rb
    20130409133700_add_timelines_project_type_id_to_projects.rb
    20130409133701_create_timelines_project_types.rb
    20130409133702_create_timelines_planning_element_types.rb
    20130409133703_create_timelines_planning_elements.rb
    20130409133704_create_timelines_scenarios.rb
    20130409133705_create_timelines_alternate_dates.rb
    20130409133706_add_timelines_responsible_id_to_projects.rb
    20130409133707_create_timelines_colors.rb
    20130409133708_create_timelines_reportings.rb
    20130409133709_create_timelines_available_project_statuses.rb
    20130409133710_create_timelines_project_associations.rb
    20130409133711_create_timelines_enabled_planning_element_types.rb
    20130409133712_create_timelines_default_planning_element_types.rb
    20130409133713_migrate_planning_element_type_to_project_association.rb
    20130409133714_remove_project_type_id_from_timelines_planning_element_types.rb
    20130409133715_create_timelines_timelines.rb
    20130409133717_add_options_to_timelines_timelines.rb
    20130409133718_remove_content_from_timelines_timelines.rb
    20130409133719_add_indexes_to_timelines_alternate_dates_to_secure_at_scope.rb
    20130409133720_add_deleted_at_to_timelines_planning_elements.rb
    20130409133721_allow_null_position_in_colors.rb
    20130409133722_allow_null_position_in_planning_element_types.rb
    20130409133723_allow_null_position_in_project_types.rb
    20130611154020_remove_timelines_namespace.rb
    20130612120042_migrate_serialized_yaml_from_syck_to_psych.rb
    20130613075253_add_force_password_change_to_user.rb
    20130619081234_create_user_passwords.rb
    20130620082322_create_work_packages.rb
    20130625124242_work_package_custom_field_data_migration.rb
    20130628092725_add_failed_login_count_last_failed_login_on_to_user.rb
    20130709084751_rename_end_date_on_alternate_dates.rb
    20130710145350_remove_end_date_from_work_packages.rb
    20130717134318_rename_changeset_wp_join_table.rb
    20130719133922_rename_trackers_to_types.rb
    20130722154555_rename_work_package_sti_column.rb
    20130723092240_add_activity_module.rb
    20130723134527_increase_journals_changed_data_limit.rb
    20130724143418_add_planning_element_type_properties_to_type.rb
    20130729114110_move_planning_element_types_to_legacy_planning_element_types.rb
    20130806075000_add_standard_column_to_type_table.rb
    20130807081927_move_journals_to_legacy_journals.rb
    20130807082645_create_normalized_journals.rb
    20130807083715_create_attachment_journals.rb
    20130807083716_change_attachment_journals_description_length.rb
    20130807084417_create_work_package_journals.rb
    20130807084708_create_message_journals.rb
    20130807085108_create_news_journals.rb
    20130807085245_create_wiki_content_journals.rb
    20130807085430_create_time_entry_journals.rb
    20130807085714_create_changeset_journals.rb
    20130807141542_remove_files_attached_to_projects_and_versions.rb
    20130813062401_add_attachable_journal.rb
    20130813062513_add_customizable_journal.rb
    20130813062523_fix_customizable_journal_value_column.rb
    20130814130142_remove_documents.rb
    20130828093647_remove_alternate_dates_and_scenarios.rb
    20130829084747_drop_model_journals_updated_on_column.rb
    20130916094339_legacy_issues_to_work_packages.rb
    20130916123916_planning_element_types_data_to_types.rb
    20130917101922_migrate_query_tracker_references_to_type.rb
    20130917122118_remove_is_in_chlog_from_types.rb
    20130917131710_planning_element_data_to_work_packages.rb
    20130918111753_migrate_user_rights.rb
    20130919105841_migrate_settings_to_work_package.rb
    20130919145142_rename_issue_relations_to_relations.rb
    20130920081120_journal_indices.rb
    20130920081135_legacy_attachment_journal_data.rb
    20130920085055_legacy_changeset_journal_data.rb
    20130920090201_legacy_news_journal_data.rb
    20130920090641_legacy_message_journal_data.rb
    20130920092800_legacy_time_entry_journal_data.rb
    20130920093823_legacy_wiki_content_journal_data.rb
    20130920094524_legacy_issue_journal_data.rb
    20130920095747_legacy_planning_element_journal_data.rb
    20130920142714_update_attachment_container.rb
    20130920150143_journal_activities_data.rb
    20131001075217_rename_issue_category_to_category.rb
    20131001105659_rename_issue_statuses_to_statuses.rb
    20131004141959_generalize_wiki_menu_items.rb
    20131007062401_migrate_text_references_to_issues_and_planning_elements.rb
    20131009083648_work_package_indices.rb
    20131015064141_migrate_timelines_end_date_property_in_options.rb
    20131015121430_index_on_users.rb
    20131016075650_add_queue_to_delayed_jobs.rb
    20131017064039_repair_work_packages_initial_attachable_journal.rb
    20131018134525_repair_messages_initial_attachable_journal.rb
    20131018134530_repair_customizable_journals.rb
    20131018134545_add_missing_attachable_journals.rb
    20131018134590_add_missing_customizable_journals.rb
    20131024115743_migrate_remaining_core_settings.rb
    20131024140048_migrate_timelines_options.rb
    20131031170857_fix_watcher_work_package_associations.rb
    20131101125921_migrate_default_values_in_work_package_journals.rb
    20131108124300_add_index_to_all_the_journals.rb
    20131114132911_migrate_planning_element_links_in_journal_notes.rb
    20131115155147_fix_parent_ids_in_work_package_journals_of_former_planning_elements.rb
    20131126112911_migrate_update_create_column_reference_in_queries.rb
    20131202094511_delete_former_deleted_planning_elements.rb
    20131210113056_repair_invalid_default_work_package_custom_values.rb
    20131216171110_migrate_timelines_enumerations.rb
    20131219084934_add_enabled_modules_name_index.rb
    20140122161742_remove_journal_columns.rb
    20140127134733_fix_issue_in_notifications.rb
    20140203141127_rename_modulename_issue_tracking.rb
    20140311120609_add_sticked_on_field_to_messages.rb
    20140411142338_clear_identity_urls_on_users.rb
    20140414141459_remove_openid_entirely.rb
    20140429152018_add_sessions_table.rb
    20140430125956_reset_content_types.rb
    20140602112515_drop_work_packages_priority_not_null_constraint.rb
    20140610125207_add_updated_at_index_to_work_packages.rb
    20141215104802_migrate_attachments_to_carrier_wave.rb
    20150116095004_patch_corrupt_attachments.rb
    20150623151337_hide_mail_by_default.rb
    20150629075221_add_scm_type_to_repositories.rb
    20150716133712_add_unique_index_on_journals.rb
    20150716163704_remove_filesystem_repositories.rb
    20150729145732_add_storage_information_to_repository.rb
    20150819143300_underscore_scm_settings.rb
    20150820133700_denullify_display_sums.rb
    20150827133700_remove_project_homepage.rb
    20151005113102_remove_summary_from_project.rb
    20151028063433_boolearlize_bool_custom_values.rb
    20151116110245_fix_customizable_bool_values.rb
    20160125143638_index_member_roles_inherited_from.rb
    20160419103544_add_attribute_visibility_to_types.rb
    20160503150449_add_indexes_for_latest_activity.rb
    20160726090624_add_slug_to_wiki_pages.rb
    20160803094931_wiki_menu_titles_to_slug.rb
    20160824121151_add_user_id_to_sessions.rb
    20160829225633_introduce_bcrypt_passwords.rb
    20160907113604_normalize_permissions.rb
    20160913081236_type_attribute_visibility_to_hash.rb
    20160913125802_timeline_options_to_hash.rb
    20160914124514_harmonize_bool_custom_values.rb
    20160926102618_setting_value_to_hash.rb
    20161017102547_add_description_to_relations.rb
    20161025135400_query_empty_column_names_to_array.rb
    20161102160032_create_enterprise_token.rb
    20161116130657_create_custom_styles.rb
    20161213191919_remove_category_name_restriction.rb
    20161219134700_add_attr_admin_to_ldap.rb
    20170116105342_add_custom_options.rb
    20170117112648_create_design_colors.rb
    20170222094032_add_attribute_groups_to_type.rb
    20170308120915_migrate_missed_list_custom_values.rb
    20170330084810_remove_translations_from_custom_fields.rb
    20170404110156_extend_query_model.rb
    20170407074032_add_hierarchy_to_query.rb
    20170411065946_v3_to_internal_group_by.rb
    20170418064453_add_timestamp_to_custom_fields.rb
    20170420082944_remove_legacy_tables.rb
    20170421071136_set_empty_columns_to_null.rb
    20170421071137_migrate_query_custom_field_filters.rb
    20170602073043_save_zoom_level_in_query.rb
    20170614131555_add_favicon_touch_icon_to_custom_style.rb
  MIGRATIONS

  @tables = [
    Tables::WorkPackages,
    Tables::Users
  ]

  def self.migrations_to_7_1
    @migrations_to_7_1
  end

  def self.migrations_to_3_0
    @migrations_to_3_0
  end

  def self.tables
    @tables
  end

  def up
    raise_on_incomplete_3_0_migrations
    raise_on_incomplete_7_1_migrations

    intersection = aggregated_versions_7_1 & all_versions

    if intersection == aggregated_versions_7_1
      remove_applied_migration_entries
    else
      run_aggregated_migrations
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration, 'Use OpenProject v7.4 for the down migrations'
  end

  private

  # All migrations that this migration aggregates have already
  # been applied. In this case, remove the information about those
  # migrations from the schema_migrations table and we're done.
  def remove_applied_migration_entries
    execute <<-SQL + (intersection.map { |version| <<-CONDITIONS }).join(' OR ')
        DELETE FROM
          #{quoted_schema_migrations_table_name}
        WHERE
    SQL
      #{version_column_for_comparison} = #{quote_value(version.to_s)}
    CONDITIONS
  end

  def raise_on_incomplete_3_0_migrations
    raise_on_incomplete_migrations(aggregated_versions_3_0, 'v2.4.0', 'ChiliProject')
  end

  def raise_on_incomplete_7_1_migrations
    raise_on_incomplete_migrations(aggregated_versions_7_1, 'v7.4.0', 'OpenProject')
  end

  def raise_on_incomplete_migrations(aggregated_versions, version_number, app_name)
    intersection = aggregated_versions & all_versions

    if !intersection.empty? && intersection != aggregated_versions

      missing = aggregated_versions - intersection

      # Only a part of the migrations that this migration aggregates
      # have already been applied. In this case, fail miserably.
      raise IncompleteMigrationsError, <<-MESSAGE.split("\n").map(&:strip!).join(' ') + "\n"
        It appears you are migrating from an incompatible version of
        #{app_name}. Yourdatabase has only some migrations from #{app_name} <
        #{version_number} Please update your database to the schema of #{app_name}
        #{version_number} and run the OpenProject migrations again. The following
        migrations are missing: #{missing}
      MESSAGE
    end
  end

  # No migrations that this migration aggregates have already been
  # applied. In this case, run the aggregated migration.
  def run_aggregated_migrations
    create_tables

    create_announcements_table

    create_attachments_table

    create_auth_sources_table

    create_boards_table

    create_changes_table

    create_changesets_table
    create_changesets_work_packages_table

    create_comments_table

    create_custom_fields_table
    create_custom_fields_projects_table
    create_custom_fields_types_table
    create_custom_options_table
    create_custom_values_table

    create_enabled_modules_table
    create_enumerations_table

    create_group_users_table

    create_categories_table

    create_relations_table

    create_statuses_table

    create_journals_table
    create_work_package_journals_table
    create_message_journals_table
    create_news_journals_table
    create_wiki_content_journals_table
    create_time_entry_journals_table
    create_changeset_journals_table
    create_attachment_journals_table
    create_attachable_journals_table
    create_customizable_journals_table

    create_roles_table
    create_role_permissions_table
    create_member_roles_table
    create_members_table

    create_messages_table
    create_news_table

    create_sessions_table

    create_project_types_table
    create_planning_element_type_colors_table
    create_reportings_table
    create_available_project_statuses_table
    create_project_associations_table
    create_timelines_table

    create_projects_table

    create_projects_types_table

    create_queries_table

    create_repositories_table

    create_settings_table

    create_time_entries_table

    create_tokens_table

    create_types_table

    create_user_preference_table
    create_user_passwords_table

    create_versions_table

    create_watchers_table
    create_wiki_content_versions
    create_wiki_contents_table

    create_wiki_pages_table
    create_wiki_redirects_table
    create_wikis_table

    create_workflows_table

    create_delayed_jobs_table

    create_wiki_menu_items

    create_custom_styles_table
    create_design_colors_table
    create_enterprise_tokens_table
  end

  def create_tables
    self.class.tables.each do |table|
      table.create(self)
    end
  end

  def create_categories_table
    create_table :categories, id: :integer, force: true do |t|
      t.integer 'project_id', default: 0, null: false
      t.string 'name', limit: 256
      t.integer 'assigned_to_id'
    end

    add_index :categories, :assigned_to_id, name: 'index_issue_categories_on_assigned_to_id'
    add_index :categories, :project_id, name: 'issue_categories_project_id'
  end

  def create_relations_table
    create_table :relations, id: :integer, force: true do |t|
      t.integer :from_id, null: false
      t.integer :to_id, null: false
      t.string :relation_type, default: '', null: false
      t.integer :delay
      t.text :description
    end

    add_index :relations, :from_id, name: 'index_issue_relations_on_issue_from_id'
    add_index :relations, :to_id, name: 'index_issue_relations_on_issue_to_id'
  end

  def create_statuses_table
    create_table :statuses, id: :integer, force: true do |t|
      t.string 'name', limit: 30, default: '', null: false
      t.boolean 'is_closed', default: false, null: false
      t.boolean 'is_default', default: false, null: false
      t.integer 'position', default: 1
      t.integer 'default_done_ratio'
    end

    add_index :statuses, :is_closed, name: 'index_issue_statuses_on_is_closed'
    add_index :statuses, :is_default, name: 'index_issue_statuses_on_is_default'
    add_index :statuses, :position, name: 'index_issue_statuses_on_position'
  end

  def create_projects_table
    create_table :projects, id: :integer, force: true do |t|
      t.string 'name', default: '', null: false
      t.text 'description'
      t.boolean 'is_public', default: true, null: false
      t.integer 'parent_id'
      t.datetime 'created_on'
      t.datetime 'updated_on'
      t.string 'identifier'
      t.integer 'status', default: 1, null: false
      t.integer 'lft'
      t.integer 'rgt'
      t.belongs_to :project_type
      t.belongs_to :responsible
      t.belongs_to :work_packages_responsible
    end

    add_index :projects, :lft, name: 'index_projects_on_lft'
    add_index :projects, :rgt, name: 'index_projects_on_rgt'

    add_index :projects, :identifier
  end

  def create_project_types_table
    create_table(:project_types) do |t|
      t.column :name, :string, default: '', null: false
      t.column :allows_association, :boolean, default: true, null: false
      t.column :position, :integer, default: 1, null: true

      t.timestamps
    end
  end

  def create_types_table
    create_table :types, id: :integer, force: true do |t|
      t.string :name, default: '', null: false
      t.integer :position, default: 1
      t.boolean :is_in_roadmap, default: true, null: false
      t.boolean :in_aggregation, default: true, null: false
      t.boolean :is_milestone, default: false, null: false
      t.boolean :is_default, default: false, null: false
      t.boolean :is_standard, default: false, null: false
      t.belongs_to :color, index: { name: :index_types_on_color_id }
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.text :attribute_visibility, hash: true
      t.text :attribute_groups
    end
  end

  def create_planning_element_type_colors_table
    create_table(:planning_element_type_colors) do |t|
      t.column :name, :string, null: false
      t.column :hexcode, :string, null: false, length: 7

      t.integer :position, default: 1, null: true

      t.timestamps
    end
  end

  def create_reportings_table
    create_table(:reportings) do |t|
      t.column :reported_project_status_comment, :text

      t.belongs_to :project
      t.belongs_to :reporting_to_project
      t.belongs_to :reported_project_status

      t.timestamps
    end
  end

  def create_available_project_statuses_table
    create_table(:available_project_statuses) do |t|
      t.belongs_to :project_type
      t.belongs_to :reported_project_status, index: { name: 'index_avail_project_statuses_on_rep_project_status_id' }

      t.timestamps
    end
  end

  def create_project_associations_table
    create_table(:project_associations) do |t|
      t.belongs_to :project_a
      t.belongs_to :project_b

      t.column :description, :text

      t.timestamps
    end
  end

  def create_timelines_table
    create_table :timelines, id: :integer do |t|
      t.string :name, null: false
      t.text :options

      t.belongs_to :project

      t.timestamps
    end
  end

  def create_versions_table
    create_table :versions, id: :integer, force: true do |t|
      t.integer 'project_id', default: 0, null: false
      t.string 'name', default: '', null: false
      t.string 'description', default: ''
      t.date 'effective_date'
      t.datetime 'created_on'
      t.datetime 'updated_on'
      t.string 'wiki_page_title'
      t.string 'status', default: 'open'
      t.string 'sharing', default: 'none', null: false
      t.date 'start_date'
    end

    add_index :versions, ['project_id'], name: 'versions_project_id'
    add_index :versions, ['sharing'], name: 'index_versions_on_sharing'
  end

  def create_watchers_table
    create_table :watchers, id: :integer, force: true do |t|
      t.string 'watchable_type', default: '', null: false
      t.integer 'watchable_id', default: 0, null: false
      t.integer 'user_id'
    end

    add_index :watchers, %i(user_id watchable_type), name: 'watchers_user_id_type'
    add_index :watchers, :user_id, name: 'index_watchers_on_user_id'
    add_index :watchers, %i(watchable_id watchable_type), name: 'index_watchers_on_watchable_id_and_watchable_type'
  end

  def create_wiki_content_versions
    create_table :wiki_content_versions, id: :integer, force: true do |t|
      t.integer 'wiki_content_id', null: false
      t.integer 'page_id', null: false
      t.integer 'author_id'
      t.binary 'data', limit: 16.megabytes
      t.string 'compression', limit: 6, default: ''
      t.string 'comments', default: ''
      t.datetime 'updated_on', null: false
      t.integer 'version', null: false
    end

    add_index :wiki_content_versions, ['updated_on'], name: 'index_wiki_content_versions_on_updated_on'
    add_index :wiki_content_versions, ['wiki_content_id'], name: 'wiki_content_versions_wcid'
  end

  def create_wiki_contents_table
    create_table :wiki_contents, id: :integer, force: true do |t|
      t.integer 'page_id', null: false
      t.integer 'author_id'
      t.text 'text', limit: 16.megabytes
      t.datetime 'updated_on', null: false
      t.integer 'lock_version', null: false
    end

    add_index :wiki_contents, :author_id, name: 'index_wiki_contents_on_author_id'
    add_index :wiki_contents, :page_id, name: 'wiki_contents_page_id'
    add_index :wiki_contents, %i[page_id updated_on]
  end

  def create_wiki_pages_table
    create_table :wiki_pages, id: :integer, force: true do |t|
      t.integer 'wiki_id', null: false
      t.string 'title', null: false
      t.datetime 'created_on', null: false
      t.boolean 'protected', default: false, null: false
      t.integer 'parent_id'
      t.string :slug, null: false
    end

    add_index :wiki_pages, :parent_id, name: 'index_wiki_pages_on_parent_id'
    add_index :wiki_pages, %i[wiki_id title], name: 'wiki_pages_wiki_id_title'
    add_index :wiki_pages, :wiki_id, name: 'index_wiki_pages_on_wiki_id'

    add_index :wiki_pages, %i[wiki_id slug], name: 'wiki_pages_wiki_id_slug', unique: true
  end

  def create_wiki_redirects_table
    create_table :wiki_redirects, id: :integer, force: true do |t|
      t.integer 'wiki_id', null: false
      t.string 'title'
      t.string 'redirects_to'
      t.datetime 'created_on', null: false
    end

    add_index :wiki_redirects, %i[wiki_id title], name: 'wiki_redirects_wiki_id_title'
    add_index :wiki_redirects, :wiki_id, name: 'index_wiki_redirects_on_wiki_id'
  end

  def create_wikis_table
    create_table :wikis, id: :integer, force: true do |t|
      t.integer 'project_id', null: false
      t.string 'start_page', null: false
      t.integer 'status', default: 1, null: false
    end

    add_index :wikis, ['project_id'], name: 'wikis_project_id'
  end

  def create_workflows_table
    create_table :workflows, id: :integer, force: true do |t|
      t.integer 'type_id', default: 0, null: false
      t.integer 'old_status_id', default: 0, null: false
      t.integer 'new_status_id', default: 0, null: false
      t.integer 'role_id', default: 0, null: false
      t.boolean 'assignee', default: false, null: false
      t.boolean 'author', default: false, null: false
    end

    add_index :workflows, :new_status_id, name: 'index_workflows_on_new_status_id'
    add_index :workflows, :old_status_id, name: 'index_workflows_on_old_status_id'
    add_index :workflows, %i[role_id type_id old_status_id], name: 'wkfs_role_tracker_old_status'
    add_index :workflows, :role_id, name: 'index_workflows_on_role_id'
  end

  def create_time_entries_table
    create_table :time_entries, id: :integer, force: true do |t|
      t.integer 'project_id', null: false
      t.integer 'user_id', null: false
      t.belongs_to :work_package
      t.float 'hours', null: false
      t.string 'comments'
      t.integer 'activity_id', null: false
      t.date 'spent_on', null: false
      t.integer 'tyear', null: false
      t.integer 'tmonth', null: false
      t.integer 'tweek', null: false
      t.datetime 'created_on', null: false
      t.datetime 'updated_on', null: false
    end

    add_index :time_entries, :activity_id, name: 'index_time_entries_on_activity_id'
    add_index :time_entries, :created_on, name: 'index_time_entries_on_created_on'
    add_index :time_entries, :work_package_id, name: 'time_entries_issue_id' # issue_id for backwards compatibility
    add_index :time_entries, :project_id, name: 'time_entries_project_id'
    add_index :time_entries, :user_id, name: 'index_time_entries_on_user_id'

    add_index :time_entries, %i[project_id updated_on]
  end

  def create_tokens_table
    create_table :tokens, id: :integer, force: true do |t|
      t.integer 'user_id', default: 0, null: false
      t.string 'action', limit: 30, default: '', null: false
      t.string 'value', limit: 40, default: '', null: false
      t.datetime 'created_on', null: false
    end

    add_index :tokens, :user_id, name: 'index_tokens_on_user_id'
  end

  def create_queries_table
    create_table :queries, id: :integer, force: true do |t|
      t.integer 'project_id'
      t.string 'name', default: '', null: false
      t.text 'filters'
      t.integer 'user_id', default: 0, null: false
      t.boolean 'is_public', default: false, null: false
      t.text 'column_names'
      t.text 'sort_criteria'
      t.string 'group_by'
      t.boolean :display_sums, default: false, null: false
      t.boolean :timeline_visible, default: false
      t.boolean :show_hierarchies, default: false
      t.integer :timeline_zoom_level, default: 0
    end

    add_index :queries, :project_id, name: 'index_queries_on_project_id'
    add_index :queries, :user_id, name: 'index_queries_on_user_id'
  end

  def create_repositories_table
    create_table :repositories, id: :integer, force: true do |t|
      t.integer 'project_id', default: 0, null: false
      t.string 'url', default: '', null: false
      t.string 'login', limit: 60, default: ''
      t.string 'password', default: ''
      t.string 'root_url', default: ''
      t.string 'type'
      t.string 'path_encoding', limit: 64
      t.string 'log_encoding', limit: 64
      t.string :scm_type, null: false
      t.integer :required_storage_bytes, :integer, limit: 8, null: false, default: 0
      t.datetime :storage_updated_at, :datetime
    end

    add_index :repositories, :project_id, name: 'index_repositories_on_project_id'
  end

  def create_settings_table
    create_table :settings, id: :integer, force: true do |t|
      t.string 'name', default: '', null: false
      t.text 'value'
      t.datetime 'updated_on'
    end

    add_index :settings, :name, name: 'index_settings_on_name'
  end

  def create_user_passwords_table
    create_table :user_passwords, id: :integer do |t|
      t.integer :user_id, null: false
      t.string :hashed_password, limit: 128, null: false
      t.string :salt, limit: 64, null: true
      t.string :type, null: false
      t.timestamps
    end

    add_index :user_passwords, :user_id
  end

  def create_group_users_table
    create_table :group_users, id: false, force: true do |t|
      t.integer :group_id, null: false
      t.integer :user_id, null: false
    end

    add_index :group_users, %i(group_id user_id), name: :group_user_ids, unique: true
  end

  def create_enabled_modules_table
    create_table :enabled_modules, id: :integer, force: true do |t|
      t.integer 'project_id'
      t.string 'name', null: false
    end

    add_index :enabled_modules, :project_id, name: 'enabled_modules_project_id'
    add_index :enabled_modules, :name, length: 8
  end

  def create_enumerations_table
    create_table :enumerations, id: :integer, force: true do |t|
      t.string 'name', limit: 30, default: '', null: false
      t.integer 'position', default: 1
      t.boolean 'is_default', default: false, null: false
      t.string 'type'
      t.boolean 'active', default: true, null: false
      t.integer 'project_id'
      t.integer 'parent_id'
    end

    add_index :enumerations, %i[id type], name: 'index_enumerations_on_id_and_type'
    add_index :enumerations, :project_id, name: 'index_enumerations_on_project_id'
  end

  def create_user_preference_table
    create_table :user_preferences, id: :integer, force: true do |t|
      t.integer 'user_id', default: 0, null: false
      t.text 'others'
      t.boolean :hide_mail, default: true
      t.string 'time_zone'
      t.boolean :impaired, default: false
    end

    add_index :user_preferences, :user_id, name: 'index_user_preferences_on_user_id'
  end

  def create_delayed_jobs_table
    create_table :delayed_jobs, id: :integer, force: true do |t|
      t.integer :priority, default: 0   # Allows some jobs to jump to the front of the queue
      t.integer :attempts, default: 0   # Provides for retries, but still fail eventually.
      t.text :handler                   # YAML-encoded string of the object that will do work
      t.text :last_error                # reason for last failure (See Note below)
      t.datetime :run_at                # When to run. Could be Time.zone.now for immediately, or sometime in the future.
      t.datetime :locked_at             # Set when a client is working on this object
      t.datetime :failed_at             # Set when all retries have failed (actually, by default, the record is deleted instead)
      t.string :locked_by               # Who is working on this object (if locked)
      t.string :queue
      t.timestamps
    end

    add_index :delayed_jobs, %i[priority run_at], name: 'delayed_jobs_priority'
  end

  def create_wiki_menu_items
    create_table :menu_items, id: :integer do |t|
      t.column :name, :string
      t.column :title, :string
      t.column :parent_id, :integer
      t.column :options, :text
      t.string :type

      t.belongs_to :navigatable
    end

    add_index :menu_items, %i(navigatable_id title)
    add_index :menu_items, :parent_id
  end

  def create_journals_table
    create_table :journals, id: :integer do |t|
      t.references :journable, polymorphic: true
      t.integer :user_id, default: 0, null: false
      t.text :notes
      t.datetime :created_at, null: false
      t.integer :version, default: 0, null: false
      t.string :activity_type
    end

    add_index :journals, :journable_id
    add_index :journals, :created_at
    add_index :journals, :journable_type
    add_index :journals, :user_id
    add_index :journals, :activity_type
    add_index :journals, %i[journable_type journable_id version], unique: true
  end

  def create_work_package_journals_table
    create_table :work_package_journals, id: :integer do |t|
      t.integer :journal_id, null: false
      t.integer :type_id, default: 0, null: false
      t.integer :project_id, default: 0, null: false
      t.string :subject, default: '', null: false
      t.text :description
      t.date :due_date
      t.integer :category_id
      t.integer :status_id, default: 0, null: false
      t.integer :assigned_to_id
      t.integer :priority_id, default: 0, null: false
      t.integer :fixed_version_id
      t.integer :author_id, default: 0, null: false
      t.integer :done_ratio, default: 0, null: false
      t.float :estimated_hours
      t.date :start_date
      t.integer :parent_id
      t.integer :responsible_id
    end

    add_index :work_package_journals, [:journal_id]
  end

  def create_message_journals_table
    create_table :message_journals, id: :integer do |t|
      t.integer :journal_id, null: false
      t.integer :board_id, null: false
      t.integer :parent_id
      t.string :subject, default: '', null: false
      t.text :content
      t.integer :author_id
      t.integer :replies_count, default: 0, null: false
      t.integer :last_reply_id
      t.boolean :locked, default: false
      t.integer :sticky, default: 0
    end

    add_index :message_journals, [:journal_id]
  end

  def create_news_journals_table
    create_table :news_journals, id: :integer do |t|
      t.integer :journal_id, null: false
      t.integer :project_id
      t.string :title, limit: 60, default: '', null: false
      t.string :summary, default: ''
      t.text :description
      t.integer :author_id, default: 0, null: false
      t.integer :comments_count, default: 0, null: false
    end

    add_index :news_journals, [:journal_id]
  end

  def create_wiki_content_journals_table
    create_table :wiki_content_journals, id: :integer do |t|
      t.integer :journal_id, null: false
      t.integer :page_id, null: false
      t.integer :author_id
      t.text :text, limit: (1.gigabyte - 1)
    end

    add_index :wiki_content_journals, [:journal_id]
  end

  def create_time_entry_journals_table
    create_table :time_entry_journals, id: :integer do |t|
      t.integer :journal_id, null: false
      t.integer :project_id, null: false
      t.integer :user_id, null: false
      t.integer :work_package_id
      t.float :hours, null: false
      t.string :comments
      t.integer :activity_id, null: false
      t.date :spent_on, null: false
      t.integer :tyear, null: false
      t.integer :tmonth, null: false
      t.integer :tweek, null: false
    end

    add_index :time_entry_journals, [:journal_id]
  end

  def create_changeset_journals_table
    create_table :changeset_journals, id: :integer do |t|
      t.integer :journal_id, null: false
      t.integer :repository_id, null: false
      t.string :revision, null: false
      t.string :committer
      t.datetime :committed_on, null: false
      t.text :comments
      t.date :commit_date
      t.string :scmid
      t.integer :user_id
    end

    add_index :changeset_journals, [:journal_id]
  end

  def create_attachment_journals_table
    create_table :attachment_journals, id: :integer do |t|
      t.integer :journal_id, null: false
      t.integer :container_id, default: 0, null: false
      t.string :container_type, limit: 30, default: '', null: false
      t.string :filename, default: '', null: false
      t.string :disk_filename, default: '', null: false
      t.integer :filesize, default: 0, null: false
      t.string :content_type, default: ''
      t.string :digest, limit: 40, default: '', null: false
      t.integer :downloads, default: 0, null: false
      t.integer :author_id, default: 0, null: false
      t.text :description
    end

    add_index :attachment_journals, [:journal_id]
  end

  def create_attachable_journals_table
    create_table :attachable_journals, id: :integer do |t|
      t.integer :journal_id, null: false
      t.integer :attachment_id, null: false
      t.string :filename, default: '', null: false
    end

    add_index :attachable_journals, :journal_id
    add_index :attachable_journals, :attachment_id
  end

  def create_customizable_journals_table
    create_table :customizable_journals, id: :integer do |t|
      t.integer :journal_id, null: false
      t.integer :custom_field_id, null: false
      t.text :value
    end

    add_index :customizable_journals, :journal_id
    add_index :customizable_journals, :custom_field_id
  end

  def create_roles_table
    create_table :roles, id: :integer, force: true do |t|
      t.string 'name', limit: 30, default: '', null: false
      t.integer 'position', default: 1
      t.boolean 'assignable', default: true
      t.integer 'builtin', default: 0, null: false
    end
  end

  def create_role_permissions_table
    create_table :role_permissions, id: :integer do |p|
      p.string :permission
      p.integer :role_id

      p.index :role_id

      p.timestamps
    end
  end

  def create_member_roles_table
    create_table :member_roles, id: :integer, force: true do |t|
      t.integer 'member_id', null: false
      t.integer 'role_id', null: false
      t.integer 'inherited_from'
    end

    add_index :member_roles, :member_id, name: 'index_member_roles_on_member_id'
    add_index :member_roles, :role_id, name: 'index_member_roles_on_role_id'

    add_index :member_roles, :inherited_from
  end

  def create_members_table
    create_table :members, id: :integer, force: true do |t|
      t.integer 'user_id', default: 0, null: false
      t.integer 'project_id', default: 0, null: false
      t.datetime 'created_on'
      t.boolean 'mail_notification', default: false, null: false
    end

    add_index :members, :project_id, name: 'index_members_on_project_id'
    add_index :members, %i[user_id project_id], name: 'index_members_on_user_id_and_project_id', unique: true
    add_index :members, :user_id, name: 'index_members_on_user_id'
  end

  def create_changesets_table
    create_table :changesets, id: :integer, force: true do |t|
      t.integer 'repository_id', null: false
      t.string 'revision', null: false
      t.string 'committer'
      t.datetime 'committed_on', null: false
      t.text 'comments'
      t.date 'commit_date'
      t.string 'scmid'
      t.integer 'user_id'
    end

    add_index :changesets, :committed_on, name: 'index_changesets_on_committed_on'
    add_index :changesets, %i[repository_id revision], name: 'changesets_repos_rev', unique: true
    add_index :changesets, %i[repository_id scmid], name: 'changesets_repos_scmid'
    add_index :changesets, :repository_id, name: 'index_changesets_on_repository_id'
    add_index :changesets, :user_id, name: 'index_changesets_on_user_id'

    add_index :changesets, %i[repository_id committed_on]
  end

  def create_changesets_work_packages_table
    create_table :changesets_work_packages, id: false, force: true do |t|
      t.integer :changeset_id, null: false
      t.integer :work_package_id, null: false
    end

    add_index :changesets_work_packages,
              %i[changeset_id work_package_id],
              unique: true,
              name: :changesets_work_packages_ids
  end

  def create_comments_table
    create_table :comments, id: :integer, force: true do |t|
      t.string 'commented_type', limit: 30, default: '', null: false
      t.integer 'commented_id', default: 0, null: false
      t.integer 'author_id', default: 0, null: false
      t.text 'comments'
      t.datetime 'created_on', null: false
      t.datetime 'updated_on', null: false
    end

    add_index :comments, :author_id, name: 'index_comments_on_author_id'
    add_index :comments, %i[commented_id commented_type], name: 'index_comments_on_commented_id_and_commented_type'
  end

  def create_custom_fields_table
    create_table :custom_fields, id: :integer, force: true do |t|
      t.string 'type', limit: 30, default: '', null: false
      t.string 'name', limit: 30, default: '', null: false
      t.string 'field_format', limit: 30, default: '', null: false
      t.text 'possible_values'
      t.string 'regexp', default: ''
      t.integer 'min_length', default: 0, null: false
      t.integer 'max_length', default: 0, null: false
      t.boolean 'is_required', default: false, null: false
      t.boolean 'is_for_all', default: false, null: false
      t.boolean 'is_filter', default: false, null: false
      t.integer 'position', default: 1
      t.boolean 'searchable', default: false
      t.text 'default_value'
      t.boolean 'editable', default: true
      t.boolean 'visible', default: true, null: false
      t.boolean :multi_value, default: false
      t.text :default_value
      t.datetime :created_at, :datetime
      t.datetime :updated_at, :datetime
    end

    add_index :custom_fields, %i[id type], name: 'index_custom_fields_on_id_and_type'
  end

  def create_custom_fields_projects_table
    create_table :custom_fields_projects, id: false, force: true do |t|
      t.integer 'custom_field_id', default: 0, null: false
      t.integer 'project_id', default: 0, null: false
    end

    add_index :custom_fields_projects,
              %i[custom_field_id project_id],
              name: 'index_custom_fields_projects_on_custom_field_id_and_project_id'
  end

  def create_projects_types_table
    create_table :projects_types, id: false, force: true do |t|
      t.integer :project_id, default: 0, null: false
      t.integer :type_id, default: 0, null: false
    end

    add_index :projects_types,
              :project_id,
              name: :projects_types_project_id
    add_index :projects_types,
              %i[project_id type_id],
              name: :projects_types_unique, unique: true
  end

  def create_custom_fields_types_table
    create_table :custom_fields_types, id: false, force: true do |t|
      t.integer 'custom_field_id', default: 0, null: false
      t.integer 'type_id', default: 0, null: false
    end

    add_index :custom_fields_types,
              %i[custom_field_id type_id],
              name: :custom_fields_types_unique,
              unique: true
  end

  def create_custom_options_table
    create_table :custom_options, id: :integer do |t|
      t.integer :custom_field_id
      t.integer :position
      t.boolean :default_value
      t.text :value
      t.datetime :created_at, :datetime
      t.datetime :updated_at, :datetime
    end
  end

  def create_custom_values_table
    create_table :custom_values, id: :integer, force: true do |t|
      t.string 'customized_type', limit: 30, default: '', null: false
      t.integer 'customized_id', default: 0, null: false
      t.integer 'custom_field_id', default: 0, null: false
      t.text 'value'
    end

    add_index :custom_values, :custom_field_id, name: 'index_custom_values_on_custom_field_id'
    add_index :custom_values, %i[customized_type customized_id], name: 'custom_values_customized'
  end

  def create_messages_table
    create_table :messages, id: :integer, force: true do |t|
      t.integer 'board_id', null: false
      t.integer 'parent_id'
      t.string 'subject', default: '', null: false
      t.text 'content'
      t.integer 'author_id'
      t.integer 'replies_count', default: 0, null: false
      t.integer 'last_reply_id'
      t.datetime 'created_on', null: false
      t.datetime 'updated_on', null: false
      t.boolean 'locked', default: false
      t.integer 'sticky', default: 0
      t.datetime :sticked_on, default: nil, null: true
    end

    add_index :messages, :author_id, name: 'index_messages_on_author_id'
    add_index :messages, :board_id, name: 'messages_board_id'
    add_index :messages, :created_on, name: 'index_messages_on_created_on'
    add_index :messages, :last_reply_id, name: 'index_messages_on_last_reply_id'
    add_index :messages, :parent_id, name: 'messages_parent_id'

    add_index :messages, %i[board_id updated_on]
  end

  def create_news_table
    create_table :news, id: :integer, force: true do |t|
      t.integer 'project_id'
      t.string 'title', limit: 60, default: '', null: false
      t.string 'summary', default: ''
      t.text 'description'
      t.integer 'author_id', default: 0, null: false
      t.datetime 'created_on'
      t.integer 'comments_count', default: 0, null: false
    end

    add_index :news, :author_id, name: 'index_news_on_author_id'
    add_index :news, :created_on, name: 'index_news_on_created_on'
    add_index :news, :project_id, name: 'news_project_id'

    add_index :news, %i[project_id created_on]
  end

  def create_sessions_table
    create_table :sessions, id: :integer do |t|
      t.string :session_id, null: false
      t.text :data
      t.belongs_to :user_id
      t.timestamps
    end

    add_index :sessions, :session_id
    add_index :sessions, :updated_at
  end

  def create_attachments_table
    create_table :attachments, id: :integer, force: true do |t|
      t.integer 'container_id', default: 0, null: false
      t.string 'container_type', limit: 30, default: '', null: false
      t.string 'filename', default: '', null: false
      t.string 'disk_filename', default: '', null: false
      t.integer 'filesize', default: 0, null: false
      t.string 'content_type', default: ''
      t.string 'digest', limit: 40, default: '', null: false
      t.integer 'downloads', default: 0, null: false
      t.integer 'author_id', default: 0, null: false
      t.datetime 'created_on'
      t.string 'description'
      t.string :file
    end

    add_index :attachments, :author_id, name: 'index_attachments_on_author_id'
    add_index :attachments, %i[container_id container_type], name: 'index_attachments_on_container_id_and_container_type'
    add_index :attachments, :created_on, name: 'index_attachments_on_created_on'
  end

  def create_auth_sources_table
    create_table :auth_sources, id: :integer, force: true do |t|
      t.string 'type', limit: 30, default: '', null: false
      t.string 'name', limit: 60, default: '', null: false
      t.string 'host', limit: 60
      t.integer 'port'
      t.string 'account'
      t.string 'account_password', default: ''
      t.string 'base_dn'
      t.string 'attr_login', limit: 30
      t.string 'attr_firstname', limit: 30
      t.string 'attr_lastname', limit: 30
      t.string 'attr_mail', limit: 30
      t.boolean 'onthefly_register', default: false, null: false
      t.boolean 'tls', default: false, null: false
      t.string :attr_admin
    end

    add_index :auth_sources, %i[id type], name: 'index_auth_sources_on_id_and_type'
  end

  def create_announcements_table
    create_table :announcements, id: :integer do |t|
      t.text :text
      t.date :show_until
      t.boolean :active, default: false
      t.timestamps
    end

    add_index :announcements, %i[show_until active]
  end

  def create_boards_table
    create_table :boards, id: :integer, force: true do |t|
      t.integer 'project_id', null: false
      t.string 'name', default: '', null: false
      t.string 'description'
      t.integer 'position', default: 1
      t.integer 'topics_count', default: 0, null: false
      t.integer 'messages_count', default: 0, null: false
      t.integer 'last_message_id'
    end

    add_index :boards, :last_message_id, name: 'index_boards_on_last_message_id'
    add_index :boards, :project_id, name: 'boards_project_id'
  end

  def create_changes_table
    create_table :changes, id: :integer, force: true do |t|
      t.integer 'changeset_id', null: false
      t.string 'action', limit: 1, default: '', null: false
      t.text 'path', null: false
      t.text 'from_path'
      t.string 'from_revision'
      t.string 'revision'
      t.string 'branch'
    end

    add_index :changes, :changeset_id, name: 'changesets_changeset_id'
  end

  def create_custom_styles_table
    create_table :custom_styles, id: :integer do |t|
      t.string :logo
      t.string :favicon
      t.string :touch_icon

      t.timestamps
    end
  end

  def create_design_colors_table
    create_table :design_colors, id: :integer do |t|
      t.string :variable
      t.string :hexcode

      t.timestamps
    end

    add_index :design_colors, :variable, unique: true
  end

  def create_enterprise_tokens_table
    create_table :enterprise_tokens, id: :integer do |t|
      t.text :encoded_token

      t.timestamps
    end
  end

  def aggregated_versions_3_0
    @aggregated_versions_3_0 ||= normalize_migrations(self.class.migrations_to_3_0)
  end

  def aggregated_versions_7_1
    @aggregated_versions_7_1 ||= normalize_migrations(self.class.migrations_to_7_1)
  end

  def normalize_migrations(migrations)
    migrations.split.map do |m|
      m.gsub(/_.*\z/, '').to_i
    end
  end

  def all_versions
    @all_versions ||= ActiveRecord::Migrator.get_all_versions
  end

  def schema_migrations_table_name
    ActiveRecord::Migrator.schema_migrations_table_name
  end

  def quoted_schema_migrations_table_name
    ActiveRecord::Base.connection.quote_table_name(schema_migrations_table_name)
  end

  def quoted_version_column_name
    ActiveRecord::Base.connection.quote_table_name('version')
  end

  def version_column_for_comparison
    "#{quoted_schema_migrations_table_name}.#{quoted_version_column_name}"
  end

  def quote_value(s)
    ActiveRecord::Base.connection.quote(s)
  end
end
