<?php

namespace Database\Factories;

use App\Models\User;
use App\Models\UvaTopic;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Post>
 */
class PostFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            "user_id" => User::all()->random()->id,
            "uva_topic_id" => UvaTopic::all()->random()->id,
            "video_url" => $this->faker->unique()->userName(),
            "video_id" => $this->faker->phoneNumber(),
            "video_pic_url" => $this->faker->imageUrl(),
            "content" => now(),
        ];
    }
}
