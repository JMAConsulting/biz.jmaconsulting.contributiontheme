<?php

require_once 'contributiontheme.civix.php';

/**
 * Implementation of hook_civicrm_config
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_config
 */
function contributiontheme_civicrm_config(&$config) {
  _contributiontheme_civix_civicrm_config($config);
}

/**
 * Implementation of hook_civicrm_xmlMenu
 *
 * @param $files array(string)
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_xmlMenu
 */
function contributiontheme_civicrm_xmlMenu(&$files) {
  _contributiontheme_civix_civicrm_xmlMenu($files);
}

/**
 * Implementation of hook_civicrm_install
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_install
 */
function contributiontheme_civicrm_install() {
  _contributiontheme_civix_civicrm_install();
}

/**
 * Implementation of hook_civicrm_uninstall
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_uninstall
 */
function contributiontheme_civicrm_uninstall() {
  _contributiontheme_civix_civicrm_uninstall();
}

/**
 * Implementation of hook_civicrm_enable
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_enable
 */
function contributiontheme_civicrm_enable() {
  _contributiontheme_civix_civicrm_enable();
}

/**
 * Implementation of hook_civicrm_disable
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_disable
 */
function contributiontheme_civicrm_disable() {
  _contributiontheme_civix_civicrm_disable();
}

/**
 * Implementation of hook_civicrm_upgrade
 *
 * @param $op string, the type of operation being performed; 'check' or 'enqueue'
 * @param $queue CRM_Queue_Queue, (for 'enqueue') the modifiable list of pending up upgrade tasks
 *
 * @return mixed  based on op. for 'check', returns array(boolean) (TRUE if upgrades are pending)
 *                for 'enqueue', returns void
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_upgrade
 */
function contributiontheme_civicrm_upgrade($op, CRM_Queue_Queue $queue = NULL) {
  return _contributiontheme_civix_civicrm_upgrade($op, $queue);
}

/**
 * Implementation of hook_civicrm_managed
 *
 * Generate a list of entities to create/deactivate/delete when this module
 * is installed, disabled, uninstalled.
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_managed
 */
function contributiontheme_civicrm_managed(&$entities) {
  _contributiontheme_civix_civicrm_managed($entities);
}

/**
 * Implementation of hook_civicrm_caseTypes
 *
 * Generate a list of case-types
 *
 * Note: This hook only runs in CiviCRM 4.4+.
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_caseTypes
 */
function contributiontheme_civicrm_caseTypes(&$caseTypes) {
  _contributiontheme_civix_civicrm_caseTypes($caseTypes);
}

/**
 * Implementation of hook_civicrm_alterSettingsFolders
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_alterSettingsFolders
 */
function contributiontheme_civicrm_alterSettingsFolders(&$metaDataFolders = NULL) {
  _contributiontheme_civix_civicrm_alterSettingsFolders($metaDataFolders);
}

function contributiontheme_civicrm_buildForm($formName, &$form) {
  if ($formName == "CRM_Contribute_Form_Contribution_Main" && $form->_id == 1) {
    CRM_Core_Resources::singleton()->addStyleFile('biz.jmaconsulting.contributiontheme', 'templates/css/style.css');
    if (\Drupal::languageManager()->getCurrentLanguage()->getId() == 'fr') {
      $form->addRadio('gift_type', ts(''), ['monthly' => ts('Mensuel'), 'one_time' => ts('Ponctuel')], null, '&nbsp;&nbsp;');
      $form->addRadio('donation_type', ts(''), ['personal' => ts('Don personnel'), 'organization' => ts('Don organisationnel')], null, '&nbsp;&nbsp;');
      $form->assign('isFr', TRUE);
      $chapterLabel = "Section locale";
    }
    else {
      $form->addRadio('gift_type', ts(''), ['monthly' => ts('Monthly'), 'one_time' => ts('One Time')], null, '&nbsp;&nbsp;');
      $form->addRadio('donation_type', ts(''), ['personal' => ts('Personal Donation'), 'organization' => ts('Organization Donation')], null, '&nbsp;&nbsp;');
      $chapterLabel = "Chapter";
    }
    $chapters = CRM_Core_OptionGroup::values('chapter_codes');
    $validChapters = [
      1000 => "Provincial Office",
      1040 => "Central West (Peel, Wellington, Waterloo, Halton, Hamilton)",
      1003 => "Chatham",
      1005 => "Durham",
      1006 => "Grey/Bruce",
      1009 => "Huron Perth",
      1010 => "Kingston",
      1011 => "London",
      1012 => "Toronto",
      1013 => "Niagara Region",
      1014 => "North East",
      1015 => "Ottawa",
      1017 => "Peterborough",
      1021 => "Sault St. Marie",
      1022 => "Simcoe",
      1023 => "Sudbury & District",
      1025 => "Thunder Bay & District",
      1026 => "Upper Canada",
      1030 => "Windsor/Essex",
      1031 => "York Region",
    ];
    asort($chapters);
    $chapters = array_intersect_key($chapters, $validChapters);
    $provincial = "Provincial Office";
    if (\Drupal::languageManager()->getCurrentLanguage()->getId() == 'fr') {
      $provincial = "Bureau provincial";
    }
    $chapters = [1000 => $provincial] + $chapters;
    $form->add('select', 'chapter_code',
      ts($chapterLabel), $chapters, FALSE, array('class' => 'crm-select2 ')
    );
    $form->setDefaults(['gift_type' => 'one_time', 'donation_type' => 'personal']);
    CRM_Core_Region::instance('page-body')->add(array(
      'template' => 'CRM/ContributionTheme.tpl',
    ));
  }
}

