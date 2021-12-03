<template>
  <section>
    <base-card>
      <error-message v-if="invalidInput" @close="invalidInput=false">
        <template #default>
          <p v-for="error in errors" :key="error">{{error}}</p>
        </template>
      </error-message>
      <h2>How was you learning experience?</h2>
      <form @submit.prevent="submitSurvey">
        <div class="form-control">
          <label for="name">Your Name</label>
          <input type="text" id="name" name="name" v-model.trim="enteredName" />
        </div>
        <h3>My learning experience was ...</h3>
        <div class="form-control">
          <input type="radio" id="rating-poor" value="poor" name="rating" v-model="chosenRating" />
          <label for="rating-poor">Poor</label>
        </div>
        <div class="form-control">
          <input
            type="radio"
            id="rating-average"
            value="average"
            name="rating"
            v-model="chosenRating"
          />
          <label for="rating-average">Average</label>
        </div>
        <div class="form-control">
          <input type="radio" id="rating-great" value="great" name="rating" v-model="chosenRating" />
          <label for="rating-great">Great</label>
        </div>
        <p
          v-if="invalidInput"
        >One or more input fields are invalid. Please check your provided data.</p>
        <p v-if="error">{{ error }}</p>
        <div>
          <base-button>Submit</base-button>
        </div>
      </form>
    </base-card>
  </section>
</template>

<script>
import axios from 'axios';
import ErrorMessage from './ErrorMessage.vue';

export default {
  components: { ErrorMessage },
  data() {
    return {
      enteredName: '',
      chosenRating: null,
      invalidInput: false,
      errors: null,
    };
  },
  // emits: ['survey-submit'],
  methods: {
    submitSurvey() {
      this.errors = null;
      axios.post('http://localhost:3000/api/v1/records', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        record: {
            name: this.enteredName,
            rating: this.chosenRating,
        },
      })
      .then((response) => {
        if (response.ok) {
          // ...
        } else if (response.unprocessable_entity) {
          // ..
        }
      }).catch(e => {
        console.log(e);
        this.errors = e.response.data;
        this.invalidInput = true;
      })

      this.enteredName = '';
      this.chosenRating = null;
    },
  },
};
</script>

<style scoped>
.form-control {
  margin: 0.5rem 0;
}

input[type='text'] {
  display: block;
  width: 20rem;
  margin-top: 0.5rem;
}
</style>
