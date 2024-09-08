import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { fn } from "@ember/helper";
import { on } from "@ember/modifier";
import DiscourseURL from "discourse/lib/url";
import User from "discourse/models/user";
import avatar from "discourse/helpers/avatar";
import { action } from "@ember/object";
import { service } from "@ember/service";
import i18n from "discourse-common/helpers/i18n";

const username = 'angus';
const allowedGroups = ['subscribers'];

export default class MessageButton extends Component {
  @tracked user;
  @service currentUser;
  @service dialog;

  constructor() {
    super(...arguments);

    User.findByUsername(username).then(user => {
      this.user = user;
    });
  }

  @action
  click() {
    const subscriber = this.currentUser.groups.some(g => allowedGroups.includes(g.name));

    if (subscriber) {
      DiscourseURL.routeTo(`/new-message?username=${username}&title=Support%20Request`);
    } else {
      this.dialog.alert("Only subscribers can send me a message on this forum.");
    }
  }

  <template>
    {{#if this.user}}
      <a class="message-button" {{on "click" (fn this.click)}}>
       {{avatar this.user imageSize="extra_large"}}
      </a>
    {{/if}}
  </template>
}