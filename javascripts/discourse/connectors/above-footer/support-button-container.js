import Component from "@glimmer/component";
import { inject as service } from "@ember/service";
import { tracked } from "@glimmer/tracking";

export default class SupportButtonContainer extends Component {
  @service chat;
  @service currentUser;
  @tracked channel;

  constructor() {
    super(...arguments);

    if (this.currentUser && settings.support_staff_username) {
      this.chat
        .upsertDmChannel({ usernames: [settings.support_staff_username] })
        .then((channel) => {
          this.channel = channel;
        });
    }
  }
}
